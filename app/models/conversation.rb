class Conversation < ApplicationRecord
  enum groups: { koch: "koch", georgia_pacific: "georgia pacific", infor: "infor", molex: "molex",
                 guardian: "guardian", sharecare: "sharecare" }
  enum status: { waiting: "waiting", active: "active", completed: "completed" }
  has_many :messages, dependent: :destroy
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User', optional: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "groups", "id", "receiver_id", "sender_id", "status", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["messages", "receiver", "sender"]
  end
end
