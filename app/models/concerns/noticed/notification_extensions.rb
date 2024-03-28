# app/models/concerns/noticed/notification_extensions.rb

module Noticed::NotificationExtensions
  extend ActiveSupport::Concern
  include ApplicationHelper

  def broadcast_update_to_bell
    broadcast_replace_to(
      "notifications_#{recipient.id}",
      target: "notification_badge",
      partial: "navbar/notification_badge",
      locals: { user: recipient }
    )
  end

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

  def broadcast_replace_to_navbar
    broadcast_replace_to(
      "notifications_#{recipient.id}",
      target: "notification-#{id}-navbar",
      partial: "notifications/notification",
      locals: { notification: self, context: "navbar" }
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

  def broadcast_replace_to_index_list
    broadcast_replace_to(
      "notifications_#{recipient.id}",
      target: "notification-#{id}-index",
      partial: "notifications/notification",
      locals: { notification: self, context: "index" }
    )
  end
end
