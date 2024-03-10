class MessagesController < ApplicationController
  before_action :set_conversation, only: %i[new create]

  def new
    @message = @conversation.messages.new
  end

  def create
    if @conversation.status == 'completed'
      collect_context
    else
      @message = @conversation.messages.create!(message_params)
    end
    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = 'Message sent' }
      format.html { redirect_to @conversation }
    end
  end

  private

  def collect_context
    @message = @conversation.messages.create!(message_params)
    if @conversation.messages.where(user_id: 3).last&.content == "What is the members ID?"
      @respond = @conversation.messages.create!(content: "What is the members date of birth?", user_id: 3)
    elsif @conversation.messages.where(user_id: 3).last&.content == "What is the members date of birth?"
      @respond = @conversation.messages.create!(content: "What is the members zip code?", user_id: 3)
    elsif @conversation.messages.where(user_id: 3).last&.content == "What is the members zip code?"
      @respond = @conversation.messages.create!(content: "Unable to locate member. Connecting to live agent.",
                                                user_id: 3)
      @conversation.update status: "waiting"
      @status = @conversation.status
    else
      @respond = @conversation.messages.create!(content: "What is the members ID?", user_id: 3)
    end
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
