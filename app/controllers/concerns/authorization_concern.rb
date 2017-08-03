module AuthorizationConcern
  private

  def require_authentication
    redirect_to new_session_path, alert: t('application.authentication_required') unless user_logged_in?
  end

  def require_admin
    redirect_to root_path, alert: t('application.admin_required') unless current_user.admin?
  end
end
