class Wishlists::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wishlist
  before_action :set_categories, :set_filtered_by_category, only: %i[index new]

  def index
    collection = @wishlist.product_wishlists.includes(:product)
    @product_wishlists = FilterProductsByCategory.call(@filtered_by_category,
                                                       collection)
                                                 .order(:bought)
                                                 .paginate(page: params[:page],
                                                           per_page: 10)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @products = FilterProductsByCategory.call(@filtered_by_category,
                                              Product.all)
                                        .paginate(page: params[:page],
                                                  per_page: 10)
  end

  def create
    product = Product.find_by(id: params[:product_id])
    product_wishlist = @wishlist.product_wishlists.build(product: product)

    if product_wishlist.save
      redirect_to wishlist_products_path(@wishlist), notice: t('.success')
    else
      flash[:error] = t('.something_went_wrong')
      redirect_to wishlist_products_path(@wishlist)
    end
  end

  def destroy
    product_wishlist = @wishlist.product_wishlists.find(params[:id])

    if product_wishlist.can_be_destroyed?
      product_wishlist.destroy
      redirect_to wishlist_products_path(@wishlist), notice: t('.success')
    else
      redirect_to wishlist_products_path(@wishlist),
                  notice: t('.cannot_destroy_bought_product')
    end
  end

  private

  def set_wishlist
    @wishlist = current_user.wishlists.find(params[:wishlist_id])
  end

  def set_categories
    @categories = Category.top_level.includes(:children)
  end

  def set_filtered_by_category
    @filtered_by_category = Category.find_by(id: params[:filter_by_category])
  end
end
