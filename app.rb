require 'sinatra'
require 'sinatra/activerecord'
#this is dedicated to Spencer, great EE who show us the power of pry!
require 'pry'
require 'soundcloud'
require 'dotenv'
require 'json'
Dotenv.load

# ======================= CLASSES ======================= 
require_relative './models/user'

# ======================= SESSIONS ====================== 

use Rack::Session::Cookie, {
  secret: ENV['SESSION_SECRET']
}

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

  def user_params(connected_user, token)
    {
      sc_user_id:              connected_user[:id],
      access_token:            token[:access_token],
      refresh_token:           token[:refresh_token],
      username:                connected_user[:username],
      avatar:                  connected_user[:avatar_url],
      country:                 connected_user[:country],
      city:                    connected_user[:city],
      track_count:             connected_user[:track_count],
      playlist_count:          connected_user[:playlist_count],
      favorites_count:         connected_user[:public_favorites_count],
      followers_count:         connected_user[:followers_count],
      following_count:         connected_user[:followings_count],
      private_tracks_count:    connected_user[:private_tracks_count],
      private_playlists_count: connected_user[:private_playlist_count]
    }
  end

  def is_user_login?
    session[:user_id]
  end
end

###############
# CONTROLLERS #
#  & ROUTES   #
###############

get '/' do
  if session[:user_id]
    redirect '/player'
  else
    redirect '/home'
  end
end

get '/home' do
  erb :home
end

get '/oauth' do
  client = get_client
  redirect client.authorize_url(display: 'popup')
end

get '/oauth/callback' do
  client  = get_client
  token   = client.exchange_token(code: params[:code])
  sc_user = get_soundcloud_user(token[:access_token], '/me')
  me_user = User.find_by(sc_user_id: sc_user[:id])

  if me_user
    me_user.access_token  = token[:access_token]
    me_user.refresh_token = token[:refresh_token]
    me_user.save
  else
    User.create(user_params(sc_user, access_token))
    me_user = User.find_by(sc_user_id: sc_user[:id])
  end
  session[:user_id] = me_user.id

  redirect '/player'
end

get '/player' do
  erb :player
end

# =================== ME CONTROLLER ====================

get '/me.json' do
  content_type :json
  me = User.find(session[:user_id])

  {
    avatar:          me.avatar,
    username:        me.username,
    city:            me.city,
    country:         me.country,
    track_count:     me.track_count,
    followers_count: me.followers_count,
    favorites_count: me.favorites_count
  }.to_json
end

# ================ LIKES CONTROLLER ====================

get '/likes.json' do
  content_type :json
  me    = User.find(session[:user_id])
  { 
    likes: get_soundcloud_user(me[:access_token], '/me/favorites'),
    clientId: ENV["MY_CLIENT_ID"] 
  }.to_json
end
