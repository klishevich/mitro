class PosterIntegration
  def auth
  	Rails.logger.info("start auth")
  	url = 'https://account.joinposter.com/api/auth?client_id=' + 
  	  client_id + '&redirect_uri=' + redirect_uri + '&response_type=code'
  	Rails.logger.info("url #{url}")
  	uri = URI.parse(url).read
  	Rails.logger.info("uri #{uri}")
  end

  private
  def client_id
  	'555'
  end

  def client_secret
  	'client_secret'
  end

  def redirect_uri
  	'http://localhost:3000/oauth2/callback'
  end
end