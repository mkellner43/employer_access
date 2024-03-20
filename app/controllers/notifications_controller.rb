class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.includes(event: :record)
  end

  def show
    @notification = current_user.notifications.find(params[:id])
  end
end
