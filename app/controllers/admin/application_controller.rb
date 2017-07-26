module Admin
  class ApplicationController < Administrate::ApplicationController
    include AuthenticationControllerMethods
    before_action :require_authentication!, :require_admin!

    def require_admin!
      redirect_to root_path, alert: t('application.admin_required') unless current_user.admin?
    end
  end
end
