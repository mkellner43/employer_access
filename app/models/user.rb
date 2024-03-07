class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { user: "user", admin: "admin" }
  validate :valid_role

  def self.email_split
    all.map { |user| user.email.split('@')[0].split('.').join(" ") }
  end

  private

  def valid_role
    unless self.class.roles.keys.include?(role)
      errors.add(:role, "must be a valid role")
    end
  end
end
