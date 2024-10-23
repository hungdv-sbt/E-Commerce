class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :count_cart

  def count_cart
    @count = current_user ? current_user.cart&.cart_items&.count : 0
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[birthday email password password_confirmation remember_me name address]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
