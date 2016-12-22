Rails.application.routes.draw do
  resources :tickets do
    resources :comments
  end
  resources :projects do
    resources :tickets, except: :index
  end
  
  get 'pages/about'

  devise_for :users
  
  root to: 'projects#index'
end
