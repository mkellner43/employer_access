# To deliver this notification:
#
# NewConversation.with(record: @post, message: "New post").deliver(User.all)

class NewConversationNotifier < ApplicationNotifier
  # Add your delivery methods
  #
  deliver_by :turbo_stream, class: "DeliveryMethods::TurboStream"
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message
end
