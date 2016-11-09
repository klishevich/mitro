class PosterIntegration
  def getWorkshops
    Rails.logger.info("start getWorkshops")
    url = 'https://busation.joinposter.com/api/menu.getWorkshops?format=json&token=' + token
    Rails.logger.info("url #{url}")
    uri = URI.parse(url).read
  end

  def clients_addClient
    my_url = 'https://busation.joinposter.com/api/clients.addClient?format=json&token=' + token
    uri = URI(my_url)
    req = Net::HTTP::Post.new(uri)
    req.set_form_data("client_name" => "Михаил Клишевич",
      "client_sex" => 1,
      "phone" => "9165926645",
      "card_number" => "123",
      "client_groups_id_client" => 1,
      "country" => "Россия",
      "city" => "Москва",
      "email" => "busation@gmail.com",
      "bonus" => 0,
      "total_payed_sum" => 0,
      "birthday" => "2016-06-29",
      "comment" => "test poster add client API")
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(req)
    end

    response_body = JSON.parse(res.body)
    Rails.logger.info("response_body: #{response_body}")

    # case res
    # when Net::HTTPSuccess, Net::HTTPRedirection
    #   # OK
    # else
    #   res.value
    # end

  end

  private

  def token
    return ENV["poster_token"].to_s
  end

end
