# frozen_string_literal: true

Rails.application.routes.draw do
  resources :links, only: %i[create show] do
    member do
      get 'redirect'
    end
  end
end
