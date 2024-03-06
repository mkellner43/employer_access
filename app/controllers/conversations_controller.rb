class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :create_join_message, only: :update

  # GET /conversations or /conversations.json
  def index
    @conversations = Conversation.includes(:receiver).all
  end

  # GET /conversations/1 or /conversations/1.json
  def show
    @message = Message.new
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
    @conversation.sender_id = current_user
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations or /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to conversation_url(@conversation), notice: "Conversation was successfully created." }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1 or /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.turbo_stream  { redirect_to @conversation, notice: 'Conversation was successfully updated.'}
        format.html { redirect_to conversation_url(@conversation), notice: "Conversation was successfully updated." }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1 or /conversations/1.json
  def destroy
    @conversation.destroy!

    respond_to do |format|
      format.html { redirect_to conversations_url, notice: "Conversation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def conversation_params
      params.require(:conversation).permit(:groups, :sender_id, :receiver_id, :status)
    end

    # Create a join message to notify other user someone has joined the conversation
    def create_join_message
      @conversation.messages.create!(user: current_user, content: "#{current_user.email} has joined the conversation")
    end
end