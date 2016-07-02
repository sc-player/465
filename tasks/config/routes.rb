Rails.application.routes.draw do
  resources :tasks
  post '/tasks/new', to: 'tasks#new'
  devise_for :users
  root 'tasks#index'
end
