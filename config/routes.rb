Rails.application.routes.draw do
  resources :projects do
    resources :tickets, except: :index
  end
  
  get 'pages/about'

  devise_for :users
  
  root to: 'projects#index'
end
