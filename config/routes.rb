Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    match '/', to: 'events#create', via: [:post, :options]
  end

  get 'sign_in', to: 'sessions#new', as: 'sign_in'
  get 'sign_out', to: 'sessions#destroy', as: 'sign_out'
  resources :sessions

  get 'sign_up', to: 'users#new', as: 'sign_up'
  resources :users

  resources :registered_applications

  get 'welcome/about'
  root to: 'welcome#index'
end
