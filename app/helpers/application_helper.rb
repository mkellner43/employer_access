module ApplicationHelper
  include Pagy::Frontend

  def user_avatar(user, size = 36)
    return user.avatar.variant(resize_to_limit: [size, size]) if user&.avatar&.attached?

    email = user ? user.email.downcase : User.find_by(role: 'robot').email.downcase
    gravatar_id = Digest::MD5.hexdigest(email)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=robohash&r=pg"
  end

  def unread_notification_count(notifications)
    return if notifications.nil? || notifications.zero?

    notifications > 100 ? '100+' : notifications
  end
end
