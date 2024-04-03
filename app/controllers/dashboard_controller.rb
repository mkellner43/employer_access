class DashboardController < ApplicationController
  def root
    if current_user.role == 'user'
      redirect_to new_conversation_path
    else
      redirect_to conversations_path
    end
  end

  def index
    # query data for chart instead of static
    @chart_data = [6500, 6418, 6456, 6526, 6356, 6456]
    @chart_labels = [
      "11 February",
      "12 February",
      "13 February",
      "14 February",
      "15 February",
      "16 February",
      "17 February",
    ]
  end
end
