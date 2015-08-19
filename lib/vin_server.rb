require 'sinatra'
require 'json'
require 'vin'

set :port, 8080
set :environment, :production

my_wine_club = WineClub.new


post '/vin/sub' do
  request.body.rewind
  sub = JSON.parse request.body.read
  puts sub  
end
