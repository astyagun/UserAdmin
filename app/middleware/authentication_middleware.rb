class AuthenticationMiddleware
  include FlashAndRedirectConcern

  def initialize(app)
    @app = app
  end

  def call(env)
    if env['rack.session'][:user_id].blank?
      flash_alert(env, 'application.authentication_required')
      return redirect
    end

    @app.call env
  end
end
