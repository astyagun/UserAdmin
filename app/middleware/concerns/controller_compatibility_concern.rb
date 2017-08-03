module ControllerCompatibilityConcern
  private

  attr_reader :env
  delegate :t, to: I18n
  delegate :root_path, :new_session_path, to: 'Rails.application.routes.url_helpers'

  def redirect_to(path, flash)
    save_flash flash
    Rack::Response.new.tap { |response| response.redirect path }.finish
  end

  # @param flash [Hash]
  def save_flash(flash)
    session[:flash] =
      ActionDispatch::Flash::FlashHash.new(flash).to_session_value
  end

  def session
    env['rack.session']
  end
end
