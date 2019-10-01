class ApplicationController < ActionController::Base
  before_action :set_shopping_cart
  helper_method :current_shopping_cart

  private

  def set_shopping_cart
    if session[:shopping_cart_id]
      @current_shopping_cart = ShoppingCart.find_by(id: session[:shopping_cart_id])
      if @current_shopping_cart.nil?
        create_shopping_cart!
      end
    else
      create_shopping_cart!
    end
  end

  def create_shopping_cart!
    @current_shopping_cart = ShoppingCart.create!
    session[:shopping_cart_id] = @current_shopping_cart.id
  end

  def current_shopping_cart
    @current_shopping_cart
  end
end
