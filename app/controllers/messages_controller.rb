class MessagesController < ApplicationController
  include ContextCollector
  before_action :set_conversation, only: %i[new create]

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

  private

  # def update_status
  #   Turbo::StreamsChannel.broadcast_update_to @conversation, target: "conversation_status",
  #                                                            html: "Group: #{@conversation.status.capitalize}"
  # end

  # def update_messages_stream(message)
  #   Turbo::StreamsChannel.broadcast_append_to @conversation, target: "messages",
  #                                                            partial: 'messages/message',
  #                                                            locals: {
  #                                                              conversation: @conversation,
  #                                                              message: message,
  #                                                              user: current_user
  #                                                            }
  # end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
