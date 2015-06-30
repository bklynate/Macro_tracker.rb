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
