class ApplicationDecorator < Draper::Decorator
  delegate_all

  def format_number_with_dots(number)
    h.number_to_currency(number, precision: 0, unit: '', delimiter: '.')
  end
end