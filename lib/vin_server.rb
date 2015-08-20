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
error do
  '{"error": "An error has occurred. Please try again later."}'
end
not_found do
  status 404
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
  not_found '{ "error": "The uid is not found or invalid"}'
end

put '/vin/sub/:id' do
  id = params[:id].to_i
  sub = parse_json request.body
  response = wc.subscriber_action.edit_sub(wc.subscribers, id, sub);
  return response.to_json unless response == nil
  not_found '{ "error": "The uid is not found or invalid"}'
end

# shipment related api calls
get '/vin/sub/:id/shipments' do
  id = params[:id]
  response = wc.subscriber_action.get_sub_shipments(wc.subscribers, id.to_i);
  return response.to_json unless response == nil
  not_found '{ "error": "The uid is not found or invalid"}'
end

get '/vin/sub/:id/shipments/:sid' do
  id = params[:id].to_i
  sid = params[:sid].to_i
  response = wc.subscriber_action.get_sub_shipment(wc.subscribers, id, sid)
  return response.to_json unless response == nil
  not_found'{ "error": "Either the uid or the sid is not found or invalid"}'
end

post '/vin/sub/:id/shipments/:sid/notes' do
  id = params[:id].to_i
  sid = params[:id].to_i

  note = parse_json request.body

  response = wc.subscriber_action.add_note_to_ship(wc.subscribers, id, sid, note)

  return response.to_json unless response == nil

  not_found '{ "error": "Either the uid or the sid is not found or invalid"}'
end

get '/vin/sub/:id/shipments/:sid/notes' do
  id = params[:id].to_i
  sid = params[:sid].to_i
  response = wc.subscriber_action.get_ship_notes(wc.subscribers, id, sid)
  return response.to_json unless response == nil
  not_found '{ "error": "Either uid or sid is not found or invalid"}'
end

get '/vin/sub/:id/shipments/:sid/notes/:nid' do
  id = params[:id].to_i
  sid = params[:sid].to_i
  nid = params[:nid].to_i
  response = wc.subscriber_action.get_note(wc.subscribers, id, sid, nid)
  return response.to_json unless response == nil
   not_found '{ "error": "Either uid, sid or nid is not found or invalid"}'
end

put '/vin/sub/:id/shipments/:sid/notes/:nid' do
  id = params[:id]
  sid = params[:sid]
  nid = params[:nid]
  note = parse_json request.body
  response = wc.subscriber_action.update_note(wc.subscribers, id, sid, nid, note)

end
