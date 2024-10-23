module ApplicationHelper
  def format_number_with_dots(number)
    return 0 if number.blank?

    number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse
  end
end
