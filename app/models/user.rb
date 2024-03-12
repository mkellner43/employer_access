class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { user: "user", admin: "admin", agent: "agent", robot: "robot" }
  validate :valid_role

  def email_split
    email.split('@')[0].split('.').join(" ")
  end

  private

  def valid_role
    unless self.class.roles.keys.include?(role)
      errors.add(:role, "must be a valid role")
    end
  end
end
