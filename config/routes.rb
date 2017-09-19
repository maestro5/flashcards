Rails.application.routes.draw do
  root 'pages#home'
  resources :cards, only: :index
end
