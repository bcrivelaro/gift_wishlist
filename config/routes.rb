Rails.application.routes.draw do
  devise_for :users, only: %i[registrations sessions]
  devise_scope :user do
    authenticated :user do
      root 'products#index'
    end

    unauthenticated do
      root 'devise/sessions#new'
    end
  end

  resources :products, only: :index
end
