class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    permit = [:login, :first_name, :last_name, :email, :password,
              :password_confirmation, :plan_id, :current_password, :avatar]
    devise_parameter_sanitizer.for(:sign_up)        { |u| u.permit(permit) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(permit) }
  end

end
