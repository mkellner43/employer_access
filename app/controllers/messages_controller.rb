class MessagesController < ApplicationController
  before_action :set_conversation, only: %i[new create]

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.create!(message_params)

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = 'Message sent' }
      format.html { redirect_to @conversation }
    end
  end

  private
  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
