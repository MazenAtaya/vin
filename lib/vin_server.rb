require 'sinatra'
require 'json'
require_relative 'vin'

set :port, 8080
set :environment, :production

wc = Vin::WineClub.new

def parse_json(body)
  body.rewind
  begin
    json = JSON.parse body.read
    return json
  rescue
    halt 400, '{"error": "You have sent malformed json"}'
  end
end

before do
  content_type "application/json"
end

# subscriber related api calls
post '/vin/sub' do
  sub = parse_json request.body
  response = wc.subscriber_action.add_sub(wc.subscribers, sub);
  wc.subscribers[0].add_shipment Shipment.new :AUG, "2015"
  return response.to_json
end

get '/vin/sub/:id' do
  id = params[:id]
  response = wc.subscriber_action.get_sub(wc.subscribers, id.to_i);
  return response.to_json unless response == nil
  halt 404, '{ "error": "The uid is not found or invalid"}'
end

put '/vin/sub/:id' do
  id = params[:id].to_i
  sub = parse_json request.body
  response = wc.subscriber_action.edit_sub(wc.subscribers, id, sub);
  return response.to_json unless response == nil
  halt 404, '{ "error": "The uid is not found or invalid"}'
end


get '/vin/sub/:id/shipments' do
  id = params[:id]
  response = wc.subscriber_action.get_sub_shipments(wc.subscribers, id.to_i);
  return response.to_json unless response == nil
  halt 404, '{ "error": "The uid is not found or invalid"}'
end

get '/vin/sub/:id/shipments/:sid' do
  id = params[:id].to_i
  sid = params[:sid].to_i
  response = wc.subscriber_action.get_sub_shipment(wc.subscribers, id, sid)
  return response.to_json unless response == nil
  halt 404,'{ "error": "Either the uid or the sid is not found or invalid"}'
end

post '/vin/sub/:id/shipments/:sid/notes' do
  id = params[:id].to_i
  sid = params[:id].to_i

  note = parse_json request.body

  response = wc.subscriber_action.add_note_to_ship(wc.subscribers, id, sid, note)

  return response.to_json unless response == nil

  halt 404, '{ "error": "Either the uid or the sid is not found or invalid"}'
end
