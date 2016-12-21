Rails.application.routes.draw do
  resources :projects do
    resources :tickets
  end
  
  get 'pages/about'

  devise_for :users
  
  root to: 'projects#index'
end
