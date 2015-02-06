var amqp = require('amqp');
var connection = amqp.createConnection({ host: 'dev.rabbitmq.com' });
var spawn = require('child_process').spawn;

connection.on('ready', function () {
  connection.queue('to-host', function (q) {
      q.bind('#');
      q.subscribe(function (message) {
        console.log('HOST MESSAGE', message);
        // spawn('./docker-start repo branch').stdout.on('data', function(chunk) {
        //   console.log(chunk.toString());
        // }).stderr.on('data', function(chunk) {
        //   console.log(chunk.toString());
        // });
      });
  });
});