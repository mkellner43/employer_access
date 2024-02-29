class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { user: "user", admin: "admin"}
  validate :valid_role

  private

  def valid_role
    unless self.class.roles.keys.include?(role)
      errors.add(:role, "must be a valid role")
    end
  end
end
