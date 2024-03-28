class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :load_notifications
  helper_method :load_notifications

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def load_notifications
    # unread_notifications = current_user.notifications.where(read_at: nil).includes(event: :record).order(created_at: :desc)
    # read_notifications = current_user.notifications.where.not(read_at: nil).includes(event: :record).order(created_at: :desc)
    @pagy, @notifications = pagy(current_user.notifications.includes(event: :record).order(created_at: :desc),
                                 items: 10) if current_user
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar])
  end
end
