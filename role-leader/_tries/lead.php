<?php

require 'vendor/autoload.php';

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use \NoahBuscher\Macaw\Macaw;
use Illuminate\Queue\Capsule\Manager as Queue;

$request = Request::createFromGlobals();

$queue = new Queue;
$queue->addConnection([
  'driver' => 'beanstalkd',
  'host' => 'localhost',
  'queue' => 'default',
]);
$queue->setAsGlobal();
$queue->getContainer()->bind('encrypter', function() {
  return new Illuminate\Encryption\Encrypter('foobar');
});
$queue->getContainer()->bind('request', function() use ($request) {
  return $request;
});

Macaw::post('/', function() use ($request, $queue) {

  $response = new Response(null, Response::HTTP_OK, ['content-type' => 'application/json']);
  $json = @json_decode($request->getContent());
  if (!$json) {
    $response->setStatusCode(Response::HTTP_BAD_REQUEST);
  }

  $queue->push('to-build', [
    'repositoryUrl' => '/vagrant/debug/repo.git',
    'revision' => 'HEAD',
    'name' => 'repo',
    'branch' => 'master',
  ]);

  $response->prepare($request);
  $response->send();
});

Macaw::dispatch();
