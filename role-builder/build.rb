require 'beaneater'
require 'json'
require 'open3'

beanstalk = Beaneater::Pool.new(['localhost:11300'])
beanstalk.jobs.register('to-build') do |job|
  body = JSON.parse(job.body)
  # puts `./build #{body['repositoryUrl']} #{body['revision']} #{body['name']} #{body['branch']}`
  CMD = %{./build #{body['repositoryUrl']} #{body['revision']} #{body['name']} #{body['branch']}}
  Open3.popen2e('bash', '-c', CMD) do |i,oe,t|
    oe.each { |line| puts line }
  end
end
beanstalk.jobs.process!
beanstalk.close
