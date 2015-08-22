require 'vin/helpers/helper_methods'

class AdminAction
  include Helpers

  def add_admin(admins, admin_hash)
    id = ""
    errors = Validator::validate_admin admin
    if errors.length == 0
      admin = Admin.new admin_hash['name']
      admins << admin
      id = admin.id
    end
    {'id' => id, 'errors' => errors}
  end

  def get_admin(admins, admin_id)
    admin = find_object_by_id admins, admin_id
  end

  def edit_admin(admins, admin_id, name)
    admin = get_admin admins, admin_id
    if admin
      errors = Validator::validate_name name
      if errors.length == 0
        admin.name = name
      end
    end
  end

  def get_revenue
    1000
  end

  def get_monthly_selection(monthly_selections, monthly_selection_id)
    find_object_by_id monthly_selections, monthly_selection_id
  end

  def add_monthly_selection(monthly_selections, monthly_selection)
    errors = Validator::validate_monthly_selection(monthly_selection)
    if errors.length == 0
      m_s = MonthlySelection.new monthly_selection.month, monthly_selection.year, monthly_selection.type, monthly_selection.wines
      monthly_selections << m_s
    end
    errors
  end

end
