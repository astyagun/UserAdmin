class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_logged_in?
    session[:user_id].present?
  end
  helper_method :user_logged_in?


  def current_user
    @current_user ||= User.find session[:user_id]
  end
  helper_method :current_user
end
