class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

  def authenticate_admin
  	Rails.logger.info('authenticate_admin')
  	if !current_user&.is_admin?
  	  flash[:notice] = t(:you_are_not_admin)
  	  redirect_to '/'
  	end
  end

  def current_order
    session1 = session[:order_id]
  	Rails.logger.info("current_order session #{session.to_json}")
  	if !session[:order_id].nil?
  		Order.find(session[:order_id])
  	else
  		Order.new
  	end
  end
end
