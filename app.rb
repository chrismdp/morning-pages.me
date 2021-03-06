module MorningPages
  class App < Sinatra::Base
    get '/' do
      haml :index
    end

    get '/css/screen.css' do
      content_type "text/css"
      scss :screen
    end

    post '/api/register' do
      user = User.new(params)
      halt 406 unless user.valid?
      user.save!

      content_type "application/json"
      user.to_json
    end

    post '/api/stats' do
      begin
        user = User.find_by(:key => params[:key])
      rescue
        halt 401
      end
      update = Update.new(params)
      halt 406 unless update.valid?
      user.updates << update
      "OK"
    end
  end
end

