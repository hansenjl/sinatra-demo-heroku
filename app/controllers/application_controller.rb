require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

  get '/goodbye' do
    erb :goodbye
  end

  get '/movies' do 
    @movies = Movie.all 
    erb :"/movies/index"
  end

end
