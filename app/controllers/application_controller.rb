class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    added_attrs = %i[birthday email password password_confirmation remember_me name address]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
