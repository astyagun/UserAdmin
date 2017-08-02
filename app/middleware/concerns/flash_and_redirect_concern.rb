module FlashAndRedirectConcern
  private

  def flash_alert(env, message_key)
    env['rack.session'][:flash] =
      ActionDispatch::Flash::FlashHash.new(alert: I18n.t(message_key)).to_session_value
  end

  def redirect
    Rack::Response.new.tap { |response| response.redirect '/' }.finish
  end
end
