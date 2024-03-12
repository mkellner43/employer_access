class Conversation < ApplicationRecord
  enum groups: { koch: 0, georgia_pacific: 1, infor: 2, molex: 3, guardian: 4, sharecare: 5 }
  enum status: { waiting: "waiting", active: "active", completed: "completed" }
  has_many :messages, dependent: :destroy
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User', optional: true
end
