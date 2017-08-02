class AuthorizationMiddleware
  include FlashAndRedirectConcern

  def initialize(app)
    @app = app
  end

  def call(env)
    user = User.find_by(id: env['rack.session'][:user_id])
    return flash_alert(env, 'application.admin_required') && redirect unless user && user.admin?
    @app.call env
  end
end
