# To deliver this notification:
#
# NewConversation.with(record: @conversation, message: "New post").deliver(User.all)

class NewConversationNotifier < ApplicationNotifier
  deliver_by :turbo_stream, class: "DeliveryMethods::TurboStream"

  notification_methods do
    def message
      params[:message]
    end
  end

  required_param :message
end
