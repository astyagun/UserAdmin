module Admin
  class ApplicationController < Administrate::ApplicationController
    include AuthenticationMethods
    include AuthorizationMethods
    before_action :require_authentication!, :require_admin!
  end
end
