module MorningPages
  class App < Sinatra::Base
    get '/' do
      "Morning Pages: This will be the website for the morning-pages gem.\n\nSee http://github.com/chrismdp/morning-pages"
    end

    post '/api/register' do
      user = User.new(params)
      halt 406 unless user.valid?
      user.save!
      user.to_json
    end

    post '/api/stats' do
      begin
        user = User.find_by(:key => params[:key])
      rescue
        halt 401
      end
      user.updates << Update.new(params)
      user.save
    end
  end
end
