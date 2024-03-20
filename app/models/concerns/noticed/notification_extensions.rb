# app/models/concerns/noticed/notification_extensions.rb

module Noticed::NotificationExtensions
  extend ActiveSupport::Concern

  def broadcast_update_to_bell
    broadcast_update_to(
      "notifications_#{recipient.id}",
      target: "notification_bell",
      partial: "navbar/notifications/bell",
      locals: { user: recipient }
    )
  end

  def broadcast_replace_to_index_count
    broadcast_replace_to(
      "notifications_index_#{recipient.id}",
      target: "notification_index_count",
      partial: "notifications/notifications_count",
      locals: { count: recipient.reload.notifications_count, unread: recipient.reload.unread_notifications_count }
    )
  end

  def broadcast_prepend_to_index_list
    broadcast_prepend_to(
      "notifications_#{recipient.id}",
      target: "notifications",
      partial: "notifications/notification",
      locals: { notification: self }
    )
  end
end
