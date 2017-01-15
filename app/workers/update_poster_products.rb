class UpdatePosterProducts
  @queue = :update_poster_products

  def self.perform
  	Logger.new('log/resque.log').info("--------- UpdatePosterProducts start !! ---------")
  	pi = PosterIntegration.new
    pi.get_products
    poster_products = pi.poster_products
    Logger.new('log/resque.log').info("poster_products #{poster_products}")
    pi.persist_products
  end
end
