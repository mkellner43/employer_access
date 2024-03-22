class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @notifications = pagy(current_user.notifications.includes(event: :record), items: 10)

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def show
    @notification = current_user.notifications.find(params[:id])
  end
end
