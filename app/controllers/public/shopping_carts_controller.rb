class Public::ShoppingCartsController < ApplicationController
  before_action :set_product_wishlist, only: :add_product

  def show
    @product_wishlists = current_shopping_cart.product_wishlists
                                              .includes(:wishlist, :product)
    @total = current_shopping_cart.product_wishlists.joins(:product).sum(:price)
  end

  def add_product
    if @product_wishlist.present?
      current_shopping_cart.product_wishlists << @product_wishlist
      current_shopping_cart.save!

      redirect_to public_wishlist_products_path(@product_wishlist.wishlist),
                  notice: t('.product_added_to_cart')
    else
      flash[:error] = t('.something_went_wrong')
      redirect_to public_wishlists_path
    end
  end

  def checkout
    if current_shopping_cart.product_wishlists.any?
      current_shopping_cart.product_wishlists.update_all(bought: true)
      current_shopping_cart.destroy
      session[:shopping_cart_id] = nil
      redirect_to public_wishlists_path, notice: t('.thank_you')
    else
      flash[:error] = t('.you_need_at_least_one_product')
      redirect_to public_wishlists_path
    end
  end

  private

  def set_product_wishlist
    @product_wishlist = ProductWishlist.find_by(id: params[:product_wishlist_id])
  end
end
