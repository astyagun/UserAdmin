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

    duplicate.send(:authorize) || @app.call(environment)
  end

  private

  def authorize
    require_authentication || require_admin
  end
end
