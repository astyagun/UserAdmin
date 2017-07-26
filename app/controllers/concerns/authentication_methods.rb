module AuthenticationMethods
  extend ActiveSupport::Concern

  LoggedInUserNotFound = Class.new StandardError

  included do
    helper_method :user_logged_in?, :current_user
    rescue_from LoggedInUserNotFound, with: :log_out
  end

  def user_logged_in?
    session[:user_id].present?
  end

  def current_user
    @current_user ||= User.find session[:user_id]
  rescue ActiveRecord::RecordNotFound
    raise LoggedInUserNotFound, 'User saved in session was not found'
  end

  def log_out
    session.delete :user_id
    redirect_to new_session_path, notice: t('sessions.destroy.success')
  end

  def require_authentication!
    redirect_to new_session_path, alert: t('application.authentication_required') unless user_logged_in?
  end
end
