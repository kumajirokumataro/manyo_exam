Rails.application.routes.draw do
  resources :tasks
  get "/" => "tasks#index"
  #get 'search', to: 'tasks#search', as: 'search'

end
