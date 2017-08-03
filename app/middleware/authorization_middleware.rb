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

    duplicate.send(:require_authentication) || duplicate.send(:require_admin) || @app.call(environment)
  end
end
