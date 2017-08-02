module Admin
  class ApplicationController < Administrate::ApplicationController
    include AuthenticationConcern
    include AuthorizationConcern
    before_action :require_authentication, :require_admin
  end
end
