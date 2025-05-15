Rails.application.routes.draw do
  root "home#index"
  get "search", to: "moldes#search"

  devise_for :users
  resources :moldes
  resources :manutencaos
  resources :processos
  resources :clientes
end
