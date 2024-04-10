class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { user: "user", admin: "admin", agent: "agent", robot: "robot" }
  validates :role, inclusion: { in: roles.keys }
  has_one_attached :avatar
  has_many :messages, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"
  has_many :sent_conversations, foreign_key: 'sender_id', dependent: :destroy, class_name: "Conversation"
  has_many :received_conversations, foreign_key: 'receiver_id', dependent: :destroy, class_name: "Conversation"
  has_one :profile, dependent: :destroy
  after_create :create_profile
  attr_accessor :remove_avatar

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "role", "updated_at", "first_name", "last_name"]
  end

  private

  def create_profile
    Profile.create!(user: self)
  end
end
