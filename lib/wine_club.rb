require 'vin'
class WineClub

attr_accessor :subscribers, :admins, :receipts, :subsciber_action, :admin_action, :deliver_action, :monthly_selections

def initialize()
  @subscibers = Array.new
  @admins = Array.new
  @receipts = Array.new
  @subsciber_action = SubsciberAction.new
  @admin_action = AdminAction.new
  @deliver_action = DeliveryPartnerAction.new
  @monthly_selections = Array.new
end



end
