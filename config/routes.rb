Rails.application.routes.draw do
  resources :conversations do
    resources :messages, only: [:new, :create]
  end
  devise_for :users
  # get "/notifications", to: "notifications#index"
  patch "/notifications/:id/mark_as_read", to: "notifications#mark_as_read", as: :mark_as_read
  patch "/notifications/:id/mark_as_unread", to: "notifications#mark_as_unread", as: :mark_as_unread
  # get "/notifications/:id", to: "notifications#show"

  resources :notifications

  root "dashboard#root"
end
