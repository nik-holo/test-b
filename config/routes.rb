Rails.application.routes.draw do
  resources :links, only: [:create, :show]
end
