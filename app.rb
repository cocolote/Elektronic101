require 'sinatra'
require 'sinatra/activerecord'
#this is dedicated to Spencer, great EE who show us the power of pry!
require 'pry'

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
