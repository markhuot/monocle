var spawn = require('child_process').spawn;

spawn('./build /vagrant/debug/repo.git HEAD repo master').stdout.on('data', function(chunk) {
  console.log(chunk.toString());
}).stderr.on('data', function(chunk) {
  console.log(chunk.toString());
});