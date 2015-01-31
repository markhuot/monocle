var amqp = require('amqp');
var connection = amqp.createConnection({ host: 'dev.rabbitmq.com' });
var spawn = require('child_process').spawn;

connection.on('ready', function () {
  connection.queue('to-build', function (q) {
      q.bind('#');
      q.subscribe(function (message) {
        spawn('./build /vagrant/debug/repo.git HEAD repo master').stdout.on('data', function(chunk) {
          console.log(chunk.toString());
        }).stderr.on('data', function(chunk) {
          console.log(chunk.toString());
        });
      });
  });
});