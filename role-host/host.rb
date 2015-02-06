require 'beaneater'
require 'json'
require 'open3'

beanstalk = Beaneater::Pool.new(['localhost:11300'])
beanstalk.jobs.register('to-host') do |job|
  body = JSON.parse(job.body)
  CMD = %{./docker-host "#{body['tar']}" "#{body['appName']}" "#{body['branch']}" "#{body['runCmd']}" "#{body['port']}" "#{body['data']}"}
  Open3.popen2e('bash', '-c', CMD) do |i,oe,t|
    oe.each { |line| puts line }
  end
end
beanstalk.jobs.process!
beanstalk.close
