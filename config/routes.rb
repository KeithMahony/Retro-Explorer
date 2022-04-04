Rails.application.routes.draw do
  devise_for :users
  resources :relics
  # get 'home/index'
  root 'home#index'
  get 'home/relic'
end
