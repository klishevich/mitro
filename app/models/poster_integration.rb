class PosterIntegration
  def getWorkshops
    Rails.logger.info("start getWorkshops")
    url = 'https://busation.joinposter.com/api/menu.getWorkshops?format=json&token=' + token
    Rails.logger.info("url #{url}")
    uri = URI.parse(url).read
  end

  # def auth
  # 	Rails.logger.info("start auth")
  # 	url = 'https://account.joinposter.com/api/auth?client_id=' + 
  # 	  client_id + '&redirect_uri=' + redirect_uri + '&response_type=code'
  # 	Rails.logger.info("url #{url}")
  # 	uri = URI.parse(url).read
  # 	Rails.logger.info("uri #{uri}")
  # end

  private
  # def client_id
  # 	'busation'
  # end

  def token
    return ENV["poster_token"].to_s
  end

  # def redirect_uri
  # 	'http://localhost:3000/oauth2/callback'
  # end
end