Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  resources :moldes
  resources :manutencaos
  resources :processos
  resources :clientes
end
