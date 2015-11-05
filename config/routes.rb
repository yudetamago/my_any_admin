Rails.application.routes.draw do
  namespace :work do
    resources :tasks
  end
end
