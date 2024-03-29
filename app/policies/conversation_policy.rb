class ConversationPolicy < ApplicationPolicy
  attr_reader :user, :conversation

  def initialize(user, conversation)
    @user = user
    @conversation = conversation
  end

  def index?
    user.role == 'agent' || user.role == 'admin'
  end

  def show?
    puts conversation
    puts user
    puts record
    user.role == 'agent' || user.role == 'admin' || user == conversation.sender
  end

  def edit?
    user.role == 'agent' || user.role == 'admin'
  end
end
