class ConversationPolicy < ApplicationPolicy
  attr_reader :user, :conversation

  def initialize(user, conversation)
    @user = user
    @conversation = conversation
  end

  def index?
    user.role == 'agent'
  end
end
