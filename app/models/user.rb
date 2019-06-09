class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :given_name, presence: true
  validates :family_name, presence: true



  ADMIN_ROLE = 'admin'
  VALID_ROLES = ["#{ADMIN_ROLE}"]
  ROLE_ABBREVS = [
    I18n.translate('app.roles.admin.abbrev'),
  ]
  ROLE_NAMES = [
    I18n.translate('app.roles.admin.name'),
  ]
  ROLES_ADMIN = 0

  # def is_admin?
  #   # roles_array = get_roles_array
  #   # return roles_array.include?(ADMIN_ROLE)
  #   if role == 'admin'
  #     return true
  #   else
  #     return false
  #   end
  # end

  def role_names
    ret = []
    roles_array = get_roles_array
    ret << ROLE_NAMES[ROLES_ADMIN] if roles_array.include?(ADMIN_ROLE)
    return ret.join(', ')
  end

  def role_admin=(val)
    roles_array = get_roles_array
    if IS_CHECKED_VALUES.include?(val) && !roles_array.include?(ADMIN_ROLE)
      roles_array << ADMIN_ROLE if !roles_array.include?(ADMIN_ROLE)
    elsif !IS_CHECKED_VALUES.include?(val) && roles_array.include?(ADMIN_ROLE)
      roles_array = roles_array - ["#{ADMIN_ROLE}"]
    end
    self.roles = roles_array.join(',')
  end
  def role_admin
    roles_array = get_roles_array
    return roles_array.include?(ADMIN_ROLE)
  end
  def is_admin?
    roles_array = get_roles_array
    return roles_array.include?(ADMIN_ROLE)
  end

  def full_name
    return "#{self.given_name} #{self.family_name}"
  end

  private

  def get_roles_array
    if self.roles.present?
      return self.roles.split(',')
    else
      return []
    end
  end

end

