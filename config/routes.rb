Rails.application.routes.draw do
  root 'pages#home'
  resources :cards
end
