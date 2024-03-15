module ContextCollector
  extend ActiveSupport::Concern
  include Broadcast

  def collect_context
    last_user_message = @conversation.messages.where(user_id: 3).last
    automatic_response = case last_user_message&.content
                         when "What is the members ID?"
                           @conversation.messages.create(content: "What is the members date of birth?", user_id: 3)
                         when "What is the members date of birth?"
                           @conversation.messages.create(content: "What is the members zip code?", user_id: 3)
                         when "What is the members zip code?"
                           @conversation.update! status: "waiting"
                           update_status
                           @conversation.messages.create(content: "Unable to locate member. Connecting to live agent...",
                                                         user_id: 3)
                         else
                           @conversation.messages.create(content: "What is the members ID?", user_id: 3)
                         end
    update_messages_stream(automatic_response)
  end
end
