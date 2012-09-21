require 'bundler/setup'
require 'sinatra'

Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment

require 'rspec'
require 'capybara/rspec'

$: << File.dirname(__FILE__) + '/../'

require 'app'

set :views, File.dirname(__FILE__) + '/../views'

Capybara.app = MorningPages::App
Mongoid.load!("config/mongoid.yml", Sinatra::Application.environment)

require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }
end
