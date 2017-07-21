Rails.application.routes.draw do
  root 'sessions#new'
  resource :session, only: %i[new create destroy]

  namespace :admin do
    resources :users
  end

  resource :home, only: :show
end
