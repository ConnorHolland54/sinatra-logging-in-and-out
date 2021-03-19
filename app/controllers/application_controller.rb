require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user
      session[:user_id] = @user.id
      redirect "/account"
    end
  end

  get '/account' do
    @user = User.find(session[:user_id])
    if @user
      erb :account
    else 
      erb :error
    end
  end

  get '/logout' do

  end


end

