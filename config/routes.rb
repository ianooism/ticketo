Rails.application.routes.draw do
  get 'pages/about'

  devise_for :users
  
  root to: 'pages#about'
end
