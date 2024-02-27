class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  broadcasts_to :conversation
end
