class AuthorizationMiddleware < AuthBaseMiddleware
  before_action :require_admin
end
