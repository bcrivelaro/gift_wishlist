Rails.application.routes.draw do
  devise_for :users, only: %i[registrations sessions]
  devise_scope :user do
    authenticated :user do
      root 'wishlists#index'
    end

    unauthenticated do
      root 'devise/sessions#new'
    end
  end

  resources :wishlists, except: :show do
    resources :products, only: %i[index new create destroy],
                         module: 'wishlists' do
      post :create
    end
  end
end
