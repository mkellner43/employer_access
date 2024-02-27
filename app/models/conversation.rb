class Conversation < ApplicationRecord
  enum groups: { koch: 0, georgia_pacific: 1, infor: 2, molex: 3, guardian: 4, sharecare: 5 }
  has_many :messages, dependent: :destroy
  broadcasts 
end
