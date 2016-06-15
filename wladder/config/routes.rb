Rails.application.routes.draw do 
  get 'words', to:'home#show'
  root "home#index"
end
