module ConversationsHelper
  # write a helper method to check if the conversation.receiver is nil

  def check_receiver(conversation)
    if conversation.receiver.nil?
      User.find_by(role: 'robot')
    else
      conversation.receiver
    end
  end
end
