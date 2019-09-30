class WishlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wishlist, only: %i[edit update destroy]

  def index
    @wishlists = current_user.wishlists.paginate(page: params[:page])
  end

  def new
    @wishlist = current_user.wishlists.build
  end

  def create
    @wishlist = current_user.wishlists.build(wishlist_params)

    if @wishlist.save
      flash[:success] = t('.success')
      redirect_to wishlist_products_path(@wishlist)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @wishlist.update(wishlist_params)
      flash[:success] = t('.success')
      redirect_to wishlist_products_path(@wishlist)
    else
      render :edit
    end
  end

  def destroy
    @wishlist.destroy

    flash[:success] = t('.success')
    redirect_to wishlists_path
  end

  private

  def set_wishlist
    @wishlist = current_user.wishlists.find(params[:id])
  end

  def wishlist_params
    params.require(:wishlist).permit(:name)
  end
end
