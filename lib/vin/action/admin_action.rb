require 'vin/helpers/helper_methods'

class AdminAction
  include Helpers

  def add_admin(admins, admin_hash)
    id = ""
    errors = Validator::validate_admin admin_hash, admins
    if errors.length == 0
      admin = Admin.new admin_hash['name']
      admins << admin
      id = admin.id
    end
    {'id' => id, 'errors' => errors}
  end

  def get_admin(admins, admin_id)
    return if !admin_id
    admin = find_object_by_id admins, admin_id
    admin.to_h if admin
  end

  def edit_admin(admins, admin_id, admin_hash)
    errors = []
    admin = find_object_by_id admins, admin_id
    if admin
      errors = Validator::validate_admin admin_hash, admins.select {|admin| admin.id != admin_id}
      if errors.length == 0
        admin.name = admin_hash['name']
      end
      {'errors' => errors}
    end
  end

  def get_admins(admins)
    {'admins' => admins.map { |e| {'id' => e.id, 'name' => e.name} }}
  end

  def get_revenue(subscribers)

    units_delivered, units_returned, wine_revenue, delivery_revenue  = 0, 0, 0, 0

    subscribers.each do |sub|
      sub.shipments.each do |ship|
        if ship.status == :Delivered
          units_delivered += ship.number_of_boxes
          wine_revenue += ship.total_cost
          delivery_revenue += ship.delivery_charge
        elsif ship.status == :Returned
          units_returned += ship.number_of_boxes
        end
      end
    end

    {
      'units_delivered' => units_delivered,
      'units_returned' => units_returned,
      'wine_revenue' => wine_revenue,
      'delivery_revenue' => delivery_revenue
    }
  end

  def get_monthly_selection(monthly_selections, monthly_selection_id)
    m_s = find_object_by_id monthly_selections, monthly_selection_id
    m_s ? m_s.to_h : nil
  end

  def get_monthly_selections(monthly_selections)
    {'monthly_selections' => monthly_selections.map { |e| {'id' => e.id, 'selection_month' => e.selection_month, 'type' => e.type.to_s.upcase}  }}
  end

  def add_monthly_selection(monthly_selections, monthly_selection, wine_club_wines)
    errors = Validator::validate_monthly_selection(monthly_selection)
    m_s_id = ""
    if errors.length == 0
      wines = []
      wines = monthly_selection['wines'].map { |wine| Wine.from_h wine }
      month, year = monthly_selection['selection_month'].split '/'
      m_s = MonthlySelection.new month.capitalize.to_sym, year.to_i, monthly_selection['type'], wines
      monthly_selections << m_s
      wines.each {|w| wine_club_wines.push w}
      m_s_id = m_s.id
    end
    {'id' => m_s_id, 'errors' => errors}
  end

end
