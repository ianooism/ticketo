Rails.application.routes.draw do
  resources :tickets, only: [] do
    resources :comments, except: [:index, :edit, :update, :destroy]
    resources :tags, only: :destroy
  end
  
  scope :tickets do
    post '/:ticket_id/watchers', to: 'watchers#create', as: 'ticket_watchers'
    delete '/:ticket_id/watchers', to: 'watchers#destroy', as: 'ticket_watcher'
  end
  
  resources :projects do
    resources :tickets, except: :index
  end
  
  get 'pages/about'

  devise_for :users
  
  root to: 'projects#index'
end
