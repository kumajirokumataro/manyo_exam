Rails.application.routes.draw do
  resources :tasks
  get "/" => "tasks#index"

end
