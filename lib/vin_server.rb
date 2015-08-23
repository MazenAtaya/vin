require 'sinatra'
require 'json'
require_relative 'vin'

set :port, 8080
set :environment, :production

configure do
  set :show_exceptions, false
end

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
#  '{"error": "Not found"}'
#  '{"error": "Not found"}'

end

# subscriber related api calls
post '/vin/sub' do
  sub = parse_json request.body
  response = wc.subscriber_action.add_sub(wc.subscribers, sub);
  ship = Shipment.new :AUG, "2015"
  ship.wines = [Wine.new, Wine.new, Wine.new]
  wc.subscribers[0].add_shipment ship

  if response['id'] != ""
    status 201
    headers "Location" => "/vin/sub/" + response["id"].to_s
  end

  response.to_json
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
  id = params[:id].to_i
  sid = params[:sid].to_i
  nid = params[:nid].to_i
  note = parse_json request.body
  response = wc.subscriber_action.update_note(wc.subscribers, id, sid, nid, note)
  return response.to_json unless response == nil
  not_found '{ "error": "Either uid, sid or nid is not found or invalid"}'
end

delete '/vin/sub/:id/shipments/:sid/notes/:nid' do
  id = params[:id].to_i
  sid = params[:sid].to_i
  nid = params[:nid].to_i
  response = wc.subscriber_action.delete_note(wc.subscribers, id, sid, nid)
  return response.to_json unless response == nil
  not_found '{ "error": "Either uid, sid or nid is not found or invalid"}'
end

#wine related api calls
get '/vin/sub/:id/wines' do
  id = params[:id].to_i
  response = wc.subscriber_action.get_wines_shipped_to_sub(wc.subscribers, id)
  return response.to_json unless response == nil
  not_found '{ "error": "uid is not found or invalid"}'
end

get '/vin/sub/:id/wines/:wid' do
  id = params[:id].to_i
  wid = params[:wid].to_i
  response = wc.subscriber_action.get_wine_shipped_to_sub wc.subscribers, id, wid
  return response.to_json unless response == nil
  not_found '{ "error": "uid or wid is not found or invalid"}'
end

get '/vin/sub/:id/wines/:wid/notes' do
  id = params[:id].to_i
  wid = params[:wid].to_i
  response = wc.subscriber_action.get_wine_notes wc.subscribers, id, wid
  return response.to_json unless response == nil
  not_found '{ "error": "uid or wid is not found or invalid"}'
end

post '/vin/sub/:id/wines/:wid/notes' do
  id = params[:id].to_i
  wid = params[:wid].to_i
  note = parse_json request.body
  response = wc.subscriber_action.add_note_to_wine wc.subscribers, id, wid, note
  return response.to_json unless response == nil
  not_found '{ "error": "uid or wid is not found or invalid"}'
end

get '/vin/sub/:id/wines/:wid/notes/:nid' do
  id = params[:id].to_i
  wid = params[:wid].to_i
  nid = params[:nid].to_i
  response = wc.subscriber_action.get_wine_note wc.subscribers, id, wid, nid
  return response.to_json unless response == nil
  not_found '{ "error": "uid, wid or nid is not found or invalid"}'
end

put '/vin/sub/:id/wines/:wid/notes/:nid' do
  id = params[:id].to_i
  wid = params[:wid].to_i
  nid = params[:nid].to_i
  note = parse_json request.body
  response = wc.subscriber_action.edit_wine_note wc.subscribers, id, wid, nid, note
  return response.to_json unless response == nil
  not_found '{ "error": "uid, wid or nid is not found or invalid"}'
end

delete '/vin/sub/:id/wines/:wid/notes/:nid' do
  id = params[:id].to_i
  wid = params[:wid].to_i
  nid = params[:nid].to_i
  response = wc.subscriber_action.delete_wine_note wc.subscribers, id, wid, nid
  return response.to_json unless response == nil
  not_found '{ "error": "uid, wid or nid is not found or invalid"}'
end

get '/vin/sub/:id/wines/:wid/rating' do
  id = params[:id].to_i
  wid = params[:wid].to_i
  nid = params[:nid].to_i
  response = wc.subscriber_action.get_wine_rating wc.subscribers, id, wid
  return response.to_json unless response == nil
  not_found '{ "error": "uid or wid is not found or invalid"}'
end

post '/vin/sub/:id/wines/:wid/rating' do
  id = params[:id].to_i
  wid = params[:wid].to_i
  nid = params[:nid].to_i
  rating = parse_json request.body
  response = wc.subscriber_action.add_wine_rating wc.subscribers, id, wid, rating
  return response.to_json unless response == nil || response == false
  return '{"error": "The rating is invalid."}' if response == false
  not_found '{ "error": "uid or wid is not found or invalid"}'
end

get '/vin/sub/:id/delivery' do
  id = params[:id].to_i
  response = wc.subscriber_action.get_delivery(wc.subscribers, id)
  return response.to_json unless response == nil
  not_found '{ "error": "uid is not found or invalid"}'
end

put '/vin/sub/:id/delivery' do
  id = params[:id].to_i
  delivery = parse_json request.body
  response = wc.subscriber_action.update_delivery(wc.subscribers, id, delivery)
  return response.to_json unless response == nil
  not_found '{ "error": "uid is not found or invalid"}'
end


post '/vin/admin' do
  admin = parse_json request.body
  response = wc.admin_action.add_admin(wc.admins, admin)

  if response['id'] != ""
    status 201
    headers "Location" => "/vin/sub/" + response["id"].to_s
  end

  response.to_json
end

get '/vin/admin/:id' do
  id = params[:id].to_i
  response = wc.admin_action.get_admin wc.admins, id
  return response.to_json unless !response
  not_found '{ "error": "id is not found or invalid"}'
end

put '/vin/admin/:id' do
  id = params[:id].to_i
  admin = parse_json request.body
  response = wc.admin_action.edit_admin(wc.admins, id, admin)
  return response.to_json unless !response
  not_found '{ "error": "id is not found or invalid"}'
end

get '/vin/admin' do
  response = wc.admin_action.get_admins wc.admins
  return response.to_json
end

post '/vin/admin/monthly_selection' do
  monthly_selection = parse_json request.body
  response = wc.admin_action.add_monthly_selection wc.monthly_selections, monthly_selection, wc.wines
  puts wc.wines.length
  if response['id'] != ""
    status 201
    headers "Location" => "/vin/admin/monthly_selection/" + response["id"].to_s
  end
  response.to_json
end

get '/vin/admin/monthly_selection/:id' do
  id = params[:id].to_i
  response = wc.admin_action.get_monthly_selection wc.monthly_selections, id
  return response.to_json unless response == nil
  not_found '{ "error": "id is not found or invalid"}'
end


get '/vin/receipt' do
  response = wc.deliver_action.get_receipts wc.receipts
  response.to_json
end

get '/vin/receipt/:id' do
  id = params[:id].to_i
  response = wc.deliver_action.get_receipt_by_id wc.receipts, id
  puts response.to_s
  return response.to_json unless !response
  not_found '{ "error": "id is not found or invalid"}'
end

post '/vin/receipt' do
  receipt_hash = parse_json request.body
  response = wc.deliver_action.add_receipt wc.subscribers, wc.receipts, receipt_hash
  response.to_json
end

get '/vin/wine/:id' do
  puts 'hello there my friend'
  id = params[:id].to_i
  puts wc.wines.length
  response = wc.subscriber_action.get_wine wc.wines, id
  puts wc.wines.length
  return response.to_json unless !response
  not_found '{ "error": "id is not found or invalid"}'
end
