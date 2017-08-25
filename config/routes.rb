Rails.application.routes.draw do
  root to: 'games#index'

  namespace :admin do
    resources :games
    resources :prices

    root to: 'games#index'
  end

  #CSV Generators
  get :best_deals, to: 'application#best_deals'
  get :rates, to: 'application#rates'
  get :glossary, to: 'application#glossary'
  get :about, to: 'application#about'
  get "/debug", to: 'games#debug'

  resources :games, only: :index
  resources :prices, only: :index
end
