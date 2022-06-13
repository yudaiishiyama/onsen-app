Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  resources :posts, only: [:index, :new, :create, :show ,:destroy, :edit, :update]
end
