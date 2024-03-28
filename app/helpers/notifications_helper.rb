module NotificationsHelper
  def has_notifications?
    current_user.notifications.any?
  end
end
