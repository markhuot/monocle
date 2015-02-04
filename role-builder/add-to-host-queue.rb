require 'beaneater'
require 'json'

beanstalk = Beaneater::Pool.new(['localhost:11300'])
tube = beanstalk.tubes["to-host"]
job = {
  :tar => ARGV[0],
  :runCmd => ARGV[1],
  :port => ARGV[2],
  :data => ARGV[3]
}.to_json
tube.put job, :pri => 5
beanstalk.close
