Rails.application.routes.draw do
  resources :tasks
  post '/tasks/new', to: 'tasks#new'

  devise_for :users, controllers:{users: "users", registrations: 'registrations'}
  get 'users/:id', to: 'users#show', as: :user
  post 'users/:id/link', to: 'users#link'

  root 'tasks#index'
end
