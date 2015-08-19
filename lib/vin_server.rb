require 'sinatra'
require 'json'
require_relative 'vin'

set :port, 8080
set :environment, :production

wc = Vin::WineClub.new

before do
  content_type "application/json"
end

post '/vin/sub' do
  request.body.rewind
  sub = JSON.parse request.body.read
  response = wc.subscriber_action.add_sub(wc.subscribers, sub);
  return response.to_json
end


get '/vin/sub/:id' do
  id = params[:id]
  response = wc.subscriber_action.get_sub(wc.subscribers, id.to_i);
  response.to_json
end
