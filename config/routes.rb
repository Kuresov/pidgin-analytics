Rails.application.routes.draw do

  #Define API routes
  namespace :api, defaults: { format: :json } do
    match 'create_event', to: 'events#create', via: [:options]
    resources :events, only: [:create]
  end

  #Get session routes
  get 'sign_in', to: 'sessions#new', as: 'sign_in'
  get 'sign_out', to: 'sessions#destroy', as: 'sign_out'
  resources :sessions

  #Get user routes
  get 'sign_up', to: 'users#new', as: 'sign_up'
  match 'sign_up', to: 'users#create', via: :post
  get 'account', to: 'users#edit', as: 'account'
  match 'account', to: 'users#update', via: :patch

  resources :registered_applications

  get 'welcome/about'
  root to: 'welcome#index'
end
