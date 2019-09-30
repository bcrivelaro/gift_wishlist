module ApplicationHelper
  def flash_class(flash_type)
    case flash_type
    when 'success', 'notice'
      'alert-success'
    when 'error', 'alert'
      'alert-danger'
    else
      flash_type.to_s
    end
  end

  def menu_path(params)
    if current_page?(wishlist_products_path)
      wishlist_products_path(params)
    else
      new_wishlist_product_path(params)
    end
  end
end
