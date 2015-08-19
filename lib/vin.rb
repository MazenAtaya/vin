require "vin/version"
require "vin/model/address"
require "vin/model/subscriber"
require 'vin/model/error'
require 'vin/model/wine'
require 'vin/model/monthly_selection'
require 'vin/model/delivery'
require 'vin/model/shipment'
require 'vin/model/note'
require 'vin/model/admin'
require 'vin/validator/validator'
require 'vin/action/subscriber_action'
require 'vin/action/delivery_partner_action'
require 'vin/action/admin_action'
require 'vin/model/receipt'
require 'vin/helpers/helper_methods'

module Vin

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

end
