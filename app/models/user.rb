class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :given_name, presence: true
  validates :family_name, presence: true

  def is_admin?
    # roles_array = get_roles_array
    # return roles_array.include?(ADMIN_ROLE)
    if role == 'admin'
      return true
    else
      return false
    end
  end

  def full_name
    return "#{self.given_name} #{self.family_name}"
  end
end
