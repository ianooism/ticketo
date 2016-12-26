Rails.application.routes.draw do
  resources :tickets, only: [] do
    resources :comments, except: [:index, :edit, :update, :destroy]
    resources :tags, only: :destroy
    resources :watchers, only: [:create, :destroy]
  end
  
  resources :projects do
    resources :tickets, except: :index
  end
  
  get 'pages/about'

  devise_for :users
  
  root to: 'projects#index'
end
