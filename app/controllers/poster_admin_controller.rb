class PosterAdminController < ApplicationController
  before_action :authenticate_admin
  
  def index
    @last_update_date = PosterClient.last&.bonus_updated_at&.strftime('%d.%m.%Y %T')
    @rinfo = Resque.info
  end

  def update_clients_bonus
  	@clients = PosterClient.where("is_active = 't'").order(:id)
  	Rails.logger.info("PosterAdminController update_clients_bonus clients to update #{@clients.count}")
  	@clients.each do |client|
  		Resque.enqueue(UpdateClientsBonus, client.poster_client_id, nil)
  	end
    flash[:notice] = t(:update_clients_bonus_started)
    redirect_to poster_admin_index_path
  end

end
