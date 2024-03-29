class DashboardController < ApplicationController
  def root
    if current_user.role == 'user'
      redirect_to new_conversation_path
    else
      redirect_to conversations_path
    end
  end
end
