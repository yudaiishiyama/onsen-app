Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  resources :posts do
  end
  resources :users, only: :show
end
