Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :trips

  post 'trips/:id/users' => 'trips#add_user', as: :join_trip
  delete 'trips/:id/users' => 'trips#delete_user', as: :leave_trip

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
