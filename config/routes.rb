Rails.application.routes.draw do
  # HOMEPAGE
  root "welcome#index"

  # FOR LOGIN/LOGOUT
  get "/registration", to: "sessions#new", as: "registration" # login/signup page
  post "/login", to: "sessions#create", as: "login"           # creates session -> homepage
  delete "/logout", to: "sessions#destroy", as: "logout"      # deletes session -> login/signup page
  get "users/verify", to: 'users#show_verify', as: 'verify'   # verification code form page
  post "users/verify"                                       # creates user -> homepage
  post "users/resend"                                         # resends code -> verification code form page

  # For new Users
  resources :users, only: [:create]

  # API
  post "/sms/received_message", as: "sms"

end
