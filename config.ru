require 'bundler/setup'
require 'sinatra'

Bundler.require :default, Sinatra::Application.environment

$: << File.dirname(__FILE__) + '/'

require 'app'

run App
