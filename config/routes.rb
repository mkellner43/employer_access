Rails.application.routes.draw do
  resources :conversations do
    resources :messages, only: [:new, :create]
  end
  devise_for :users
  get "/notifications", to: "notifications#index"
  get "/notifications/:id", to: "notifications#show"

  root "dashboard#root"
end
