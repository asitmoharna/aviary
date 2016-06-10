Rails.application.routes.draw do
  resources :birds, except: [:edit, :update], defaults: { format: :json }
end
