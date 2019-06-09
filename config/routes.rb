Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :users do
    member do
      get 'profile'
    end
    collection do
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
