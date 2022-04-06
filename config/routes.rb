Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  resources :relics
  # get 'home/index'
  root 'home#index'
  get 'home/relic'
end
