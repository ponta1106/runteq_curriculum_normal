Rails.application.routes.draw do
  root to: 'static_pages#top'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  resources :users

  resources :boards do
    resources :comments, only: %i[create], shallow: true
    collection do
      get :bookmarks
    end
  end

  resources :bookmarks, only: %i[create destroy]
end
