require 'sinatra'
require 'sinatra/activerecord'
#this is dedicated to Spencer, great EE who show us the power of pry!
require 'pry'
require 'soundcloud'
require 'dotenv'
Dotenv.load

###########
# HELPERS #
###########

helpers do
  def get_client
    client = Soundcloud.new(
      client_id:     ENV['MY_CLIENT_ID'],
      client_secret: ENV['MY_CLIENT_SECRET'],
      redirect_uri:  'http://localhost:4567/oauth/callback'
    )
  end

  def get_soundcloud_user(access_token, uri)
    Soundcloud.new(access_token: access_token).get(uri)
  end
end

###############
# CONTROLLERS #
#  & ROUTES   #
###############

get '/' do
  #redirect '/home'
  erb :player
end

get '/home' do
  erb :home
end

get '/oauth' do
  client = get_client
  redirect client.authorize_url(display: 'popup')
end

get '/oauth/callback' do
  client        = get_client
  access_token  = client.exchange_token(code: params[:code])
  @me           = get_soundcloud_user(access_token[:access_token], '/me')
  binding.pry
  erb :player
end
