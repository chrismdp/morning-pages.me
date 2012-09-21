require 'spec_helper'
require 'rack/test'
require 'user'
require 'update'

feature "Api" do
  include Rack::Test::Methods
  def app
    MorningPages::App
  end

  def register
    post '/api/register', :username => 'foo', :email => 'foo@example.com'
    MorningPages::User.last
  end


  scenario "User registers" do
    expect {
      register
    }.to change { MorningPages::User.count }.by(1)
    last_response.status.should == 200
    user = MorningPages::User.last
    user.username.should == 'foo'
    user.email.should == 'foo@example.com'
    user.key.should_not be_empty
    JSON.parse(last_response.body)['key'].should == user.key
  end

  scenario "User already registered" do
    register
    register
    last_response.status.should == 406
  end

  def send_stats(key)
    post '/api/stats', :key => key, :count => '2', :average_length => '3.4'
  end

  scenario "User posts stats" do
    user = register
    expect {
      send_stats(user.key)
    }.to change { MorningPages::User.last.updates.count }.by(1)
    last_response.body.should == "OK"
  end

  scenario "User cannot post without correct key" do
    send_stats("foo")
    last_response.status.should == 401
  end

  scenario "User must post count" do
    user = register
    expect {
      post '/api/stats', :key => user.key, :average_length => '3.4'
    }.not_to change { MorningPages::User.last.updates.count }
    last_response.status.should == 406
  end
end

