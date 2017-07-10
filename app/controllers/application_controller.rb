class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :is_admin?
  helper_method :current_order

  def is_admin?
    current_user && current_user.admin
  end

  def current_order
    if session[:order_id]
      Order.find(session[:order_id])
    else
      Order.new
    end    
  end

  # Custom parameters / Strong Parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

   protected

   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
   end

end
