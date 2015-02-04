require 'sinatra'
require 'beaneater'
require 'json'

set :port, 8001

post '/' do
  content_type :json

  beanstalk = Beaneater::Pool.new(['localhost:11300'])
  tube = beanstalk.tubes["to-build"]
  job = {
    :repositoryUrl => "/vagrant/debug/repo.git",
    :revision => "HEAD",
    :name => "repo",
    :branch => "master"
  }.to_json
  tube.put job, :pri => 5
  beanstalk.close

  { :status => 200, :message => 'Job Accepted' }.to_json
end