class AuthorizationMiddleware
  include ControllerCompatibilityConcern
  include AuthenticationConcern
  include AuthorizationConcern

  def initialize(app)
    @app = app
  end

  def call(environment)
    duplicate = dup # To isolate instance variables between calls
    duplicate.instance_variable_set :@env, environment

    duplicate.send(:redirect_unauthorized) || @app.call(environment)
  end

  private

  def redirect_unauthorized
    require_authentication || require_admin
  end
end
