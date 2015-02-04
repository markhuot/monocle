require 'beaneater'
require 'json'

beanstalk = Beaneater::Pool.new(['localhost:11300'])
# tube = beanstalk.tubes["to-build"]
# while tube.peek(:ready)
#   job = tube.reserve
#   puts "job value is #{JSON.parse(job.body)["key"]}!"
#   job.delete
# end
beanstalk.jobs.register('to-build') do |job|
  body = JSON.parse(job.body)
  puts `./build #{body['repositoryUrl']} #{body['revision']} #{body['name']} #{body['branch']}`
end
beanstalk.jobs.process!
beanstalk.close

# './build /vagrant/debug/repo.git HEAD repo master'