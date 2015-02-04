require 'beaneater'
require 'json'

beanstalk = Beaneater::Pool.new(['localhost:11300'])
beanstalk.jobs.register('to-host') do |job|
  body = JSON.parse(job.body)
  puts body
  puts `./docker-host #{body['tar']} #{body['runCmd']} #{body['port']} #{body['data']}`
end
beanstalk.jobs.process!
beanstalk.close
