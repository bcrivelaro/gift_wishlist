class ApplicationController < ActionController::Base
  before_action :set_shopping_cart
  helper_method :current_shopping_cart

  private

  def set_shopping_cart
    if session[:shopping_cart_id]
      @current_shopping_cart = ShoppingCart.find(session[:shopping_cart_id])
    else
      @current_shopping_cart = ShoppingCart.create!
      session[:shopping_cart_id] = @current_shopping_cart.id
    end
  end

  def current_shopping_cart
    @current_shopping_cart
  end
end
