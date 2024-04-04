class Conversation < ApplicationRecord
  enum groups: { koch: "koch", georgia_pacific: "georgia pacific", infor: "infor", molex: "molex",
                 guardian: "guardian", sharecare: "sharecare" }
  enum status: { waiting: "waiting", active: "active", completed: "completed" }
  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'
  belongs_to :receiver, foreign_key: 'receiver_id', class_name: 'User', optional: true
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"

  def self.group_by_day(time_period = 7.days.ago)
    posts_by_day = where('created_at >= ?', time_period).group('DATE(created_at)').count

    # Create a range of dates from the start date to today
    date_range = (time_period.to_date..Date.today)

    # Fill in the gaps in posts_by_day with 0s
    date_range.map { |date| [date.strftime('%b %d, %Y'), posts_by_day[date] || 0] }.to_h
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "groups", "id", "status", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["receiver", "sender"]
  end
end
