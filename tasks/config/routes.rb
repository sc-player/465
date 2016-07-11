Rails.application.routes.draw do
  resources :tasks, except: [:edit]
  post '/tasks/new', to: 'tasks#new'
  patch '/subtasks/:id/complete', to: 'tasks#complete'
  patch 'subtasks/:id', to: 'tasks#createSubtasks'
  post 'subtasks/:id', to: 'tasks#split', as: 'subtask'
  patch 'subtasks/:id/completeExtra', to: 'tasks#completeExtra'

  devise_for :users, controllers:{users: "users", registrations: 'registrations'}
  get 'users/:id', to: 'users#show', as: :user

  root 'tasks#index'
end
