Rails.application.routes.draw do
  resources :conversations do
    resources :messages, only: [:new, :create]
  end
  devise_for :users

  root "dashboard#root"
end
