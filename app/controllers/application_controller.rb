class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_admin
  	Rails.logger.info('authenticate_admin')
  	if !current_user&.is_admin?
  	  flash[:notice] = t(:you_are_not_admin)
  	  redirect_to '/'
  	end
  end
end
