class DashboardController < ApplicationController
  def root
    if current_user.role == 'user'
      redirect_to new_conversation_path
    else
      redirect_to conversations_path
    end
  end

  def index
    time_period = params[:time_period].present? ? params[:time_period].to_i.days.ago : 7.days.ago
    chart_data = Conversation.group_by_day(time_period)
    @chart_values = chart_data.values.to_json
    @chart_labels = chart_data.keys.to_json
    @filtered_time_periods = [['Last 7 days', 7], ['Last 14 days', 14], ['Last month', 30], ['Last 6 months', 180],
                              ['All time', 10000]]
    @selected_time_period = @filtered_time_periods.find { |label, days|
                              days == params[:time_period].to_i
                            }&.first || 'Last 7 days'
  end
end
