module AuthorizationConcern
  private

  def require_admin
    redirect_to root_path, alert: t('application.admin_required') unless current_user.admin?
  end
end
