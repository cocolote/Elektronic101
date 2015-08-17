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

###############
# CONTROLLERS #
#  & ROUTES   #
###############

get '/' do
  redirect '/home'
end

get '/home' do
  erb :home
end

get '/oauth' do
  client = get_client
  redirect client.authorize_url(display: 'popup')
end

get '/oauth/callback' do
  client       = get_client
  access_token = client.exchange_token(code: params[:code])
  # Create the user and store the access_token, refresh_tokn
  current_user = get_soundcloud_user(access_token[:access_token], '/me')
  likes        = get_soundcloud_user(access_token[:access_token], '/me/favorites')
  binding.pry
end
