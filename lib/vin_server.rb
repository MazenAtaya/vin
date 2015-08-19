require 'sinatra'
require 'json'
require 'vin'

class ::Hash

  def method_missing(name)

    return self[name] if key? name

    self.each { |k,v| return v if k.to_s.to_sym == name }

    super.method_missing name

  end

end


set :port, 8080
set :environment, :production

my_wine_club = Vin::WineClub.new

before do
  content_type "application/json"
end

post '/vin/sub' do
  request.body.rewind
  sub = JSON.parse request.body.read
  response = my_wine_club.subscriber_action.add_sub(my_wine_club.subscribers, sub);
  return response.to_json
end
