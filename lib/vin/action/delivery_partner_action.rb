class DeliveryPartnerAction


def get_customers_to_deliver_to(subscribers, month, year)
  subscribers.select do |sub|
    sub.shipments.none? do |e|
      e.month == month && e.year == year
    end
  end
end



end
