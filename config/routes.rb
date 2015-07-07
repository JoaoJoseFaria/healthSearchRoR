Rails.application.routes.draw do

  root :to => "home#index"
  resources :locations
  resources :xmlocations

end
