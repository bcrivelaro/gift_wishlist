Rails.application.routes.draw do
  devise_for :users, only: %i[registrations sessions]
  devise_scope :user do
    authenticated :user do
      root 'wishlists#index'
    end

    unauthenticated do
      root 'public/wishlists#index'
    end
  end

  resources :wishlists, except: :show do
    resources :products, only: %i[index new create destroy],
                         module: 'wishlists' do
      post :create
    end
  end

  namespace :public do
    resources :wishlists, only: :index do
      resources :products, only: :index, module: 'wishlists'
    end

    resource :shopping_cart, only: :show do
      post :add_product
      post :checkout
    end
  end
end
