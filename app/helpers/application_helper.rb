module ApplicationHelper
  include Pagy::Frontend

  def user_avatar(user, size = 36)
    if user.avatar.attached?
      user.avatar.variant(resize_to_limit: [size, size])
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      default = 'robohash'
      rating = 'pg'
      "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{CGI.escape(size.to_s)}&d=#{CGI.escape(default)}&r=#{CGI.escape(rating)}"
    end
  end
end
