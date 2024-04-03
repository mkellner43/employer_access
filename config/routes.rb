Rails.application.routes.draw do
  resources :conversations do
    resources :messages, only: [:new, :create]
  end
  devise_for :users
  patch "/notifications/:id/mark_as_read", to: "notifications#mark_as_read", as: :mark_as_read
  patch "/notifications/mark_all_as_read", to: "notifications#mark_all_as_read", as: :mark_all_as_read
  patch "/notifications/:id/mark_as_unread", to: "notifications#mark_as_unread", as: :mark_as_unread
  patch "/notifications/mark_all_as_unread", to: "notifications#mark_all_as_unread", as: :mark_all_as_unread
  resources :notifications, only: [:index, :show]
  get "/dashboard", to: "dashboard#index"

  root "dashboard#root"
end
