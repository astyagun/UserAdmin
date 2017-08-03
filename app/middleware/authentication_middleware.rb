class AuthenticationMiddleware < AuthBaseMiddleware
  before_action :require_authentication
end
