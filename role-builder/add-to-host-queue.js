console.log('ADDED!');
console.log('$TAR', process.argv[2]);
console.log('$RUNCMD', process.argv[3]);
console.log('$PORT', process.argv[4]);
console.log('$DATAONLY', process.argv[5]);

var amqp = require('amqp');
var amqpConnection = amqp.createConnection({ host: 'dev.rabbitmq.com' });

amqpConnection.publish('to-host', {
	"tar": process.argv[2],
  "runcmd": process.argv[3],
  "port": process.argv[4],
  "dataonly": process.argv[5]
});
