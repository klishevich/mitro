class PosterIntegration
  attr_accessor :poster_client_id, :client_info

  def initialize(poster_client_id)
     @poster_client_id = poster_client_id
  end

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

  def get_client_info
    Rails.logger.info("start get_client_info")
    url = 'https://busation.joinposter.com/api/clients.getClientInfo?format=json&token=' + token + 
      '&client_id=' + @poster_client_id.to_s
    Rails.logger.info("url #{url}")
    res = URI.parse(url).read
    @client_info = JSON.parse(res)
    Rails.logger.info("@client_info #{@client_info}")
  end

  def persist_client_bonus
    now_date = Time.now
    if client_info['response'].count > 0
      pc = PosterClient.where(poster_client_id: poster_client_id).first
      if client_info['response'][0]['prize_products'].count > 0
        pc.has_bonus = true
        pc.bonus_text = 'has bonus, hurray!'
        pc.bonus_updated_at = now_date
      else
        pc.has_bonus = false
        pc.bonus_text = 'no bonus'
        pc.bonus_updated_at = now_date
      end
      pc.save
    end
  end

  private

  def token
    return ENV["poster_token"].to_s
  end

end
