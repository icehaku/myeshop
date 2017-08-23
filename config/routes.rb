Rails.application.routes.draw do
  resources :games, only: :index
  resources :prices, only: :index

  root to: 'games#index'
end
