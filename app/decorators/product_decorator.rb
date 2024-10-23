class ProductDecorator < ApplicationDecorator
  def formatted_price
    format_number_with_dots(object.price)
  end
end
