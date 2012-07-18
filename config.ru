require 'sinatra'

get '/' do
  "This will be the website for the morning-pages gem.\n\nSee http://github.com/chrismdp/morning-pages"
end

run Sinatra::Application
