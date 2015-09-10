require 'vin/helpers/helper_methods'

class DeliveryPartnerAction

  include Helpers

  def get_customers_to_deliver_to(subscribers, monthly_selection, box_price, delivery_charge)
    subs = subscribers.select do |sub|
      sub.shipments.none? do |e|
        e.month == monthly_selection.month && e.year == monthly_selection.year
      end
    end

    if !monthly_selection
      subs = []
    end

    subs.each do |sub|
      shipment = Shipment.new monthly_selection.month, monthly_selection.year
      shipment.type = sub.delivery.selection_type
      shipment.wines = monthly_selection.wines
      shipment.number_of_boxes = sub.delivery.number_of_boxes
      shipment.box_price = box_price
      shipment.delivery_charge = delivery_charge
      sub.add_shipment shipment
    end

    subs = subscribers.select do |sub|
      sub.shipments.any? { |e| e.month == monthly_selection.month && e.year == monthly_selection.year && e.status == :Pending  }
    end
    subs = subs.map { |e|
      {
        'name' => e.name,
        'phone' => e.phone,
        'email' => e.email,
        'address' => e.address.to_h,
        'dow' => e.shipments.last.day_of_week,
        'tod' => e.shipments.last.time_of_day,
        'type' =>e.delivery.selection_type,
        'number_of_boxes' => e.delivery.number_of_boxes
      }
    }

    {'deliver_to' => subs}

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
      mark_shipment_as_received sub
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

  def mark_shipment_as_received(sub)
    month = Time.now.strftime("%b").to_sym
    year =  Time.now.year
    ship = sub.shipments.find do |ship|
      ship.month == month && ship.year == year
    end
    if ship
      ship.status = :Delivered
    end
  end



end
