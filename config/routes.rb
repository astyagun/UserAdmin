Rails.application.routes.draw do
  root to: redirect('/session/new', status: 302)

  resource :session, only: %i[new create destroy]

  namespace :admin do
    resources :users
  end

  get 'home' => 'homes#show'
end
