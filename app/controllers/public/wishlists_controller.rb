class Public::WishlistsController < ApplicationController
  def index
    @wishlists = Wishlist.all.paginate(page: params[:page], per_page: 10)
  end
end
