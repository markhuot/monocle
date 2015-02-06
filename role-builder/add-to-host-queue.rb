require 'beaneater'
require 'json'

beanstalk = Beaneater::Pool.new(['localhost:11300'])
tube = beanstalk.tubes["to-host"]
job = {
  :tar => ARGV[0],
  :appName => ARGV[1],
  :branch => ARGV[2],
  :runCmd => ARGV[3],
  :port => ARGV[4],
  :data => ARGV[5]
}.to_json
tube.put job, :pri => 5
beanstalk.close
