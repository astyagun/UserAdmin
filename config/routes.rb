require 'sidekiq/web'

Rails.application.routes.draw do
  root to: redirect('/session/new', status: 302)

  resources :users, only: %i[new create] do
    # This route is related to admin section, but can't be placed under /admin
    # because of https://github.com/thoughtbot/administrate/issues/481
    resources :details_deliveries, only: :create
  end
  resource :session, only: %i[new create destroy]

  namespace :admin do
    resources :users
    root to: redirect('/admin/users', status: 302)
  end

  get 'home' => 'homes#show'

  Sidekiq::Web.use AuthenticationMiddleware
  Sidekiq::Web.use AuthorizationMiddleware
  mount Sidekiq::Web => '/sidekiq'
end

ActiveSupport::Notifications.instrument 'routes_loaded.application'
