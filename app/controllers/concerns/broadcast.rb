module Broadcast
  extend ActiveSupport::Concern

  def update_status
    Turbo::StreamsChannel.broadcast_update_to @conversation, target: "conversation_status",
                                                             html: "#{@conversation.status.capitalize}"

    Turbo::StreamsChannel.broadcast_replace_to @conversation, target: "user_conversation_details_conversation_#{@conversation.id}",
                                                              partial: 'conversations/user_conversation_details',
                                                              locals: { conversation: @conversation }
    Turbo::StreamsChannel.broadcast_replace_to 'agent_conversations', target: "agent_conversation_#{@conversation.id}",
                                                                      partial: 'conversations/conversation',
                                                                      locals: { conversation: @conversation, user: current_user }
  end

  def update_messages_stream(message)
    Turbo::StreamsChannel.broadcast_append_to @conversation, target: "messages",
                                                             partial: 'messages/message',
                                                             locals: {
                                                               conversation: @conversation,
                                                               message: message,
                                                               user: current_user
                                                             }
  end
end
