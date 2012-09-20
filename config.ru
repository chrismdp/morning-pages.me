require 'bundler/setup'
require 'sinatra'

Bundler.require :default, Sinatra::Application.environment

require 'app'

run App
