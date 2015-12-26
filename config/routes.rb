Rails.application.routes.draw do
  resources :tasks
  root to: 'top#show'
end
