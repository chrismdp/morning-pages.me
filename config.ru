require 'bundler/setup'
require 'sinatra'

Bundler.require :default, Sinatra::Application.environment
Mongoid.load!("config/mongoid.yml", Sinatra::Application.environment)

$: << File.dirname(__FILE__) + '/'

require 'user'
require 'update'
require 'app'

run MorningPages::App
