Rails.application.routes.draw do 
  get 'words', to:'home#show'
  get 'index', to:'home#index'
  root "home#index"
end
