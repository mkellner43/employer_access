class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { user: "user", admin: "admin", agent: "agent", robot: "robot" }
  validates :role, inclusion: { in: roles.keys }
  has_one_attached :avatar
  has_many :sent_conversations, class_name: 'Conversation', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'receiver_id', dependent: :destroy
  has_many :messages, dependent: :destroy
  before_create :set_default_avatar

  def set_default_avatar
    avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.png')),
                  filename: 'default_avatar.png', content_type: 'image/png')
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "role", "updated_at"]
  end
end
