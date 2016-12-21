Rails.application.routes.draw do
  resources :tickets
  resources :projects
  
  get 'pages/about'

  devise_for :users
  
  root to: 'projects#index'
end
