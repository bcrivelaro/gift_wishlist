class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_filtered_by_category

  def index
    @categories = Category.top_level.includes(:children)
    @products = FilterProductsByCategory.call(@filtered_by_category)
  end

  private

  def load_filtered_by_category
    @filtered_by_category = Category.find_by(id: params[:filter_by_category])
  end
end
