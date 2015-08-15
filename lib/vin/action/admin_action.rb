class AdminAction

  def find_object_by_id(objects, id)
    objects.each do |obj|
      if (obj.id == id)
        return obj
      end
    end
  end

  def add_admin(admins, admin)
    errors = Validator::validate_admin admin
    if errors.length == 0
      admin = Admin.new admin.name
      admins << admin
      admin.id
    end
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
end
