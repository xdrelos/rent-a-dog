class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    attr_user = [:username, :first_name, :last_name, :email, :biography]
    devise_parameter_sanitizer.permit(:sign_up, keys: attr_user)

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: attr_user)

    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
  end
end
