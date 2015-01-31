var amqp = require('amqp');
var connection = amqp.createConnection({ host: 'dev.rabbitmq.com' });
var spawn = require('child_process').spawn;

connection.on('ready', function () {
  connection.queue('to-build', function (q) {
      q.bind('#');
      q.subscribe(function (message) {
        spawn('./git-clone /vagrant/debug/repo.git HEAD | ./docker-build repo master').stdout.on('data', function(chunk) {
          console.log(chunk.toString());
        }).stderr.on('data', function(chunk) {
          console.log(chunk.toString());
        });
      });
  });
});