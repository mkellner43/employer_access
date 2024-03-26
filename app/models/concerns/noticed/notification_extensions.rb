# app/models/concerns/noticed/notification_extensions.rb

module Noticed::NotificationExtensions
  extend ActiveSupport::Concern
  include ApplicationHelper

  def broadcast_update_to_bell
    broadcast_replace_to(
      "notifications_#{recipient.id}",
      target: "notification_badge",
      html: "<span id='notification_badge' class='absolute top-2 right-1 inline-flex items-center justify-center p-1 text-xs font-bold leading-none text-red-100 transform translate-x-1/2 -translate-y-1/2 bg-red-600 rounded-full'>#{unread_notification_count(recipient.notifications.unread.count)}</span>",
      locals: { user: recipient }
    )
  end
  # GET BELL TO WORK!!

  def broadcast_prepend_to_navbar
    broadcast_prepend_to(
      "notifications_#{recipient.id}",
      target: "notification_frame",
      partial: "notifications/notification",
      locals: { notification: self, context: "navbar" }
    )
  end

  def broadcast_remove_to_navbar
    broadcast_remove_to(
      "notifications_#{recipient.id}",
      target: "notification-#{id}-navbar",
    )
  end

  def broadcast_prepend_to_index_list
    broadcast_prepend_to(
      "notifications_#{recipient.id}",
      target: "notification_frame_index",
      partial: "notifications/notification",
      locals: { notification: self, context: "index" }
    )
  end

  def broadcast_remove_to_index
    broadcast_remove_to(
      "notifications_#{recipient.id}",
      target: "notification-#{id}-index",
    )
  end
end
