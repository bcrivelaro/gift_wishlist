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
end
