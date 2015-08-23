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
    return if !receipt_id
    receipt = find_object_by_id receipts, receipt_id
    return receipt.to_h unless !receipt
  end

  def add_receipt(subscribers, receipts, receipt_hash)
    id = ""
    errors = Validator::validate_receipt(subscribers, receipt_hash)
    if errors.length == 0
      sub = subscribers.find {|e| e.name.downcase == receipt_hash['name'].downcase }
      receipt = Receipt.new sub.id, sub.name, receipt_hash['received_by']
      receipts << receipt
      id = receipt.id
    end
    {'id' => id, 'errors' => errors }
  end

  def get_receipts(receipts)
    {
      'receipts' => receipts.map { |e|
              {
                'id' => e.id,
                'date' => e.date,
                'subscriber' => e.sub_id,
                'name' => e.sub_name
              }
            }
    }
  end



end
