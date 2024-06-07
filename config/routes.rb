Rails.application.routes.draw do
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'dashboard/payment_methods', to: 'dashboard#payment_methods', as: 'payment_methods'
  get 'surveys/created', to: 'surveys#created', as: 'created_surveys'
  get 'statistics', to: 'statistics#show', as: 'statistics'
  get 'notifications', to: 'notifications#index', as: 'notifications'

  resources :profiles, only: [:show, :edit, :update]
  resources :bank_accounts, only: [:new, :create, :edit, :update]
  resources :wallets, only: [:new, :create, :edit, :update, :destroy]
  resources :transactions, only: [:index, :show, :new, :create]
  resources :categories, only: [:index] do 
    member do
      get 'show_products'
    end
    resources :products do
      resources :surveys do
        resources :responses, only: [:create]
        resources :questions do
          resources :choices
        end
      end
    end
  end
  root 'categories#index'
  get 'home/about_us', to: 'home#about_us'
  get 'home/for_you', to: 'home#for_you'
  get 'home/how_it_works', to: 'home#how_it_works'
  get 'home/why_us', to: 'home#why_us'
  get 'products/show', to: 'products#show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
