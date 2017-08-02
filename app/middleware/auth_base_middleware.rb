class AuthBaseMiddleware
  include ControllerCompatibilityConcern
  include AuthenticationConcern
  include AuthorizationConcern

  def self.before_action(method_name) # rubocop:disable Style/TrivialAccessors
    @before_action = method_name
  end

  def initialize(app)
    @app = app
  end

  def call(environment)
    duplicate = dup # To isolate instance variables between calls
    duplicate.instance_variable_set :@env, environment

    duplicate.send(:run_before_action) || @app.call(environment)
  end

  private

  def run_before_action
    send self.class.instance_variable_get(:@before_action)
  end
end
