Rails.application.routes.draw do
  resources :tasks
  post '/tasks/new', to: 'tasks#new'
  patch 'subtasks/:id/complete', to: 'tasks#complete'

  devise_for :users, controllers:{users: "users", registrations: 'registrations'}
  get 'users/:id', to: 'users#show', as: :user
  post 'users/:id/link', to: 'users#link'

  root 'tasks#index'
end
