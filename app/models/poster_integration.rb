class PosterIntegration
  attr_accessor :client_info

  def getWorkshops
    Rails.logger.info("start getWorkshops")
    url = 'https://busation.joinposter.com/api/menu.getWorkshops?format=json&token=' + token
    Rails.logger.info("url #{url}")
    uri = URI.parse(url).read
  end

  def clients_addClient(client_name, client_sex, phone, country, city, email, birthday)
    my_url = 'https://busation.joinposter.com/api/clients.addClient?format=json&token=' + token
    uri = URI(my_url)
    req = Net::HTTP::Post.new(uri)
    req.set_form_data(
      "client_name" => client_name,
      "client_sex" => client_sex,
      "phone" => phone,
      "card_number" => "",
      "client_groups_id_client" => 1,
      "country" => country,
      "city" => city,
      "email" => email,
      "bonus" => 0,
      "total_payed_sum" => 0,
      "birthday" => birthday,
      "comment" => "Создан через API с сайта mitrofood")
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(req)
    end

    response_body = JSON.parse(res.body)
    Rails.logger.info("3.1) PosterIntegration response_body: #{response_body}")

    return response_body['response']
  end

  def get_client_info(poster_client_id)
    Rails.logger.info("start get_client_info")
    url = 'https://busation.joinposter.com/api/clients.getClientInfo?format=json&token=' + token + 
      '&client_id=' + poster_client_id.to_s
    Rails.logger.info("url #{url}")
    res = URI.parse(url).read
    @client_info = JSON.parse(res)
    Rails.logger.info("@client_info #{@client_info}")
  end

  private

  def token
    return ENV["poster_token"].to_s
  end

end
