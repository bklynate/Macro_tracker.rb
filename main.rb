require 'rubygems'
require 'sinatra'
require 'pry'

use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => '19874310BKLYN'

get '/' do  
  if session[:username].empty?
    redirect '/set_username'
  elsif session[:username]
    redirect '/set_macros'
  end
end

get '/set_username' do

  erb :set_username
end

post '/set_username' do

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
    halt erb(:set_macros)
  end

  erb :set_macros
end
