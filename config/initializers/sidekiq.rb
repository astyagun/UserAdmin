require 'sidekiq/web'

ActiveSupport::Notifications.subscribe 'routes_loaded.application' do
  Sidekiq::Web.app_url = Rails.application.routes.url_helpers.admin_users_path
  Sidekiq::Web.set :session_secret, Rails.application.secrets.secret_key_base
end
