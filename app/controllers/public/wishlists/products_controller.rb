class Public::Wishlists::ProductsController < ApplicationController
  before_action :set_wishlist
  before_action :set_categories, :set_filtered_by_category, only: %i[index new]

  def index
    collection = @wishlist.product_wishlists.includes(:product)
    @product_wishlists = FilterProductsByCategory.call(@filtered_by_category,
                                                       collection)
                                                 .paginate(page: params[:page],
                                                           per_page: 10)

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_wishlist
    @wishlist = Wishlist.find(params[:wishlist_id])
  end

  def set_categories
    @categories = Category.top_level.includes(:children)
  end

  def set_filtered_by_category
    @filtered_by_category = Category.find_by(id: params[:filter_by_category])
  end
end