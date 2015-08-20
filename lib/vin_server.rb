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
  wc.subscribers[0].add_shipment Shipment.new :AUG, "2015"
  return response.to_json
end


get '/vin/sub/:id' do
  id = params[:id]
  response = wc.subscriber_action.get_sub(wc.subscribers, id.to_i);
  response.to_json
end

put '/vin/sub/:id' do
  id = params[:id]
  sub = JSON.parse request.body.read
  response = wc.subscriber_action.edit_sub(wc.subscribers, id.to_i, sub);
  response.to_json
end

get '/vin/sub/:id/shipments' do
  id = params[:id]
  response = wc.subscriber_action.get_sub_shipments(wc.subscribers, id.to_i);
  return response.to_json unless response == nil
  status 404
  body '{ "error": "The uid is not found or invalid"}'
end

get '/vin/sub/:id/shipments/:sid' do
  id = params[:id].to_i
  sid = params[:sid].to_i
  response = wc.subscriber_action.get_sub_shipment(wc.subscribers, id, sid)
  return response.to_json unless response == nil
  status 404
  body '{ "error": "Either the uid or the sid is not found or invalid"}'
end


post '/vin/sub/:id/shipments/:sid/notes' do
  id = params[:id].to_i
  sid = params[:id].to_i
  request.body.rewind
  note = JSON.parse request.body.read
  response = wc.subscriber_action.add_note_to_ship(wc.subscribers, id, sid, note)
  return response.to_json unless response == nil
  status 404
  body '{ "error": "Either the uid or the sid is not found or invalid"}'
end
