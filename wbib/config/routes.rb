Rails.application.routes.draw do
  resources :references
  root "references#index" 
end
