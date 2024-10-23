class CartItemDecorator < ApplicationDecorator
  def formatted_total_price
    format_number_with_dots(object.product.price * object.quantity)
  end

  def formatted_price
    format_number_with_dots(object.product.price)
  end
end
