class UpdateClientsBonus
  @queue = :update_clients_bonus

  def self.perform(poster_client_id, products)
  	Logger.new('log/resque.log').info("--------- UpdateClientsBonus start !! ---------")
  	Logger.new('log/resque.log').info("poster_client_id #{poster_client_id}, products #{products}")
  	pi = PosterIntegration.new
    pi.poster_client_id = poster_client_id
    pi.get_client_info
    client_info = pi.client_info
    Logger.new('log/resque.log').info("client_info #{client_info}")
    pi.persist_client_bonus
  end
end
