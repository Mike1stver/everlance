Rails.application.routes.draw do
  resources :registrations, only:[:create]
  resources :sessions, only:[:create]
  namespace :admin do
    resources :tasks
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
