class PosterAdminController < ApplicationController
  before_filter :authenticate_admin
  
  def index
  end

  def update_clients_bonus
  	Rails.logger.info("PosterAdminController update_clients_bonus client id = 10")
  	Resque.enqueue(UpdateClientsBonus, 10, nil)
    flash[:notice] = t(:update_clients_bonus_started)
    redirect_to poster_admin_index_path
  end

end