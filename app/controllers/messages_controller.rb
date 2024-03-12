class MessagesController < ApplicationController
  before_action :set_conversation, only: %i[new create]
  before_action :set_user

  def new
    @message = @conversation.messages.new
  end

  def create
    message = @conversation.messages.create!(message_params)
    update_messages_stream(message)
    if @conversation.status == 'completed'
      collect_context
    end
    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = 'Message sent' }
      format.html { redirect_to @conversation }
    end
  end

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

  private

  def update_status
    Turbo::StreamsChannel.broadcast_update_to @conversation, target: "conversation_status",
                                                             html: "Group: #{@conversation.status.capitalize}"
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

  def set_user
    @user = current_user
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end

# seems to be an issue with the locals being passed in and accessed differently
