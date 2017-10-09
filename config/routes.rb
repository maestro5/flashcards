Rails.application.routes.draw do
  root 'pages#home'
  resources :cards do
    patch :check, on: :member
  end
end
