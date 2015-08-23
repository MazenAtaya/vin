require 'vin/helpers/helper_methods'

class AdminAction
  include Helpers

  def add_admin(admins, admin_hash)
    id = ""
    errors = Validator::validate_admin admin_hash
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
      errors = Validator::validate_admin admin_hash
      if errors.length == 0
        admin.name = admin_hash['name']
      end
      {'errors' => errors}
    end
  end

  def get_admins(admins)
    {'admins' => admins.map { |e| {'id' => e.id, 'name' => e.name} }}
  end

  def get_revenue
    1000
  end

  def get_monthly_selection(monthly_selections, monthly_selection_id)
    find_object_by_id monthly_selections, monthly_selection_id
  end

  def get_monthly_selections(monthly_selections)
    {'monthly_selections' => monthly_selections.map { |e| {'id' => e.id, 'selection_month' => e.selection_month, 'type' => e.type.to_s.upcase}  }}
  end

  def add_monthly_selection(monthly_selections, monthly_selection)
    errors = Validator::validate_monthly_selection(monthly_selection)
    m_s_id = ""
    if errors.length == 0
      wines = []
      wines = monthly_selection['wines'].map { |wine| Wine.from_h wine }
      m_s = MonthlySelection.new monthly_selection['month'], monthly_selection['year'], monthly_selection['type'], wines
      monthly_selections << m_s
      m_s_id = m_s.id
    end
    {'id' => m_s_id, 'errors' => errors}
  end

end
