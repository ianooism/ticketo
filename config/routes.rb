Rails.application.routes.draw do
  resources :projects
  get 'pages/about'

  devise_for :users
  
  root to: 'pages#about'
end
