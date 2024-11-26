Rails.application.routes.draw do
  devise_for :users
  root "conversation_windows#index"

  resources :conversation_windows do
    resources :groups, only: [:new, :create, :show]
    resources :messages, only: [:create]  # Nest messages under conversation_windows
    resources :statuses, only: [:create, :show, :new,:index]  # Add route for creating and showing statuses
  end
end
