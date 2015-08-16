require 'vin/helpers/helper_methods'

class DeliveryPartnerAction

  include Helpers

  def get_customers_to_deliver_to(subscribers, month, year)
    subscribers.select do |sub|
      sub.shipments.none? do |e|
        e.month == month && e.year == year
      end
    end
  end

  def get_receipt_by_id(receipts, receipt_id)
    find_object_by_id receipts, receipt_id
  end

end
