Rails.application.routes.draw do
  resources :links, only: [:create, :show] do
    member do
      get 'redirect'
    end
  end
end
