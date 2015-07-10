require 'rubygems'
require 'sinatra'
require 'pry'

use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => '19874310BKLYN'

get '/' do  
  if session[:username]
    redirect '/set_macros'
  else
    redirect '/set_username'
  end
end

get '/set_username' do
  erb :set_username
end

post '/set_username' do
  if session[:username].empty?
    @error = "<strong>Please provide your name..</strong>"
  elsif session[:username].to_i > 0
    @error = "<strong>No numbers allowed in this field</strong>"
  elsif session[:username].length > 13
    @error = "<strong>Too many characters..</strong>"
  else
    session[:username] = params[:username].capitalize
    redirect '/set_macros'
  end
  
  erb :set_username
end

get '/set_macros' do
  erb :set_macros
end

post '/set_macros' do
  session[:protein_macros] = params[:protein_macros].to_i
  session[:fat_macros] = params[:fat_macros].to_i
  session[:carb_macros] = params[:carb_macros].to_i

  if session[:protein_macros] < 0 || session[:fat_macros] < 0 || session[:carb_macros] < 0
    @error = "Invalid Input"
  elsif session[:protein_macros] && session[:fat_macros] && session[:carb_macros] 
    redirect '/display_macros'
  end

  erb :set_macros
end

get '/display_macros' do
  erb :display_macros
end