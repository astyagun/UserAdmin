Rails.application.routes.draw do
  root to: redirect('/session/new', status: 302)

  resources :users, only: %i[new create] do
    resources :details_deliveries, only: :create
  end
  resource :session, only: %i[new create destroy]

  namespace :admin do
    resources :users
    root to: redirect('/admin/users', status: 302)
  end

  get 'home' => 'homes#show'
end
