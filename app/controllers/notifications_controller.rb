class NotificationsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :set_notification, only: %i[show mark_as_read mark_as_unread]

  def index
    @pagy, @notifications = pagy(current_user.notifications.includes(event: :record).order(created_at: :desc),
                                 items: 10)

    respond_to do |format|
      format.turbo_stream { render locals: { user: current_user } }
      format.html
    end
  end

  def show
    mark_as_read
    respond_to do |format|
      format.html { redirect_to @notification.record }
    end
  end

  def mark_as_read
    @notification.mark_as_read!
    broadcast_notification_update
  end

  def mark_as_unread
    @notification.mark_as_unread!
    broadcast_notification_update
  end

  def mark_all_as_read
    current_user.notifications.mark_as_read
    redirect_back fallback_location: notifications_path
  end

  def mark_all_as_unread
    current_user.notifications.mark_as_unread
    redirect_back fallback_location: notifications_path
  end

  private

  def broadcast_notification_update
    @notification.broadcast_update_to_bell
    @notification.broadcast_replace_to_navbar
    @notification.broadcast_replace_to_index_list
  end

  def notification_params
    params.require(:notification).permit(:message)
  end

  def set_notification
    @notification = current_user.notifications.find(params[:id])
  end
end
