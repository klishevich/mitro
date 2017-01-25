class PosterIntegration
  attr_accessor :poster_client_id, :client_info, :poster_products

  # def initialize(poster_client_id)
  #   @poster_client_id = poster_client_id
  # end

  # TEST METHOD
  def getWorkshops
    Rails.logger.info("start getWorkshops")
    url = account_url + 'menu.getWorkshops?format=json&token=' + token
    Rails.logger.info("url #{url}")
    uri = URI.parse(url).read
  end

  def add_client(client_name, client_sex, phone, country, city, email, birthday)
    my_url = account_url + 'clients.addClient?format=json&token=' + token
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
    url = account_url + 'clients.getClientInfo?format=json&token=' + token + '&client_id=' + @poster_client_id.to_s
    Rails.logger.info("url #{url}")
    res = URI.parse(url).read
    @client_info = JSON.parse(res)
    Rails.logger.info("@client_info #{@client_info}")
  end

  def persist_client_bonus
    now_date = Time.now
    if client_info['response'].count > 0
      pc = PosterClient.where(poster_client_id: poster_client_id).first
      prize_products = client_info['response'][0]['prize_products']
      Logger.new('log/resque.log').info("PosterIntegration prize_products.to_s #{prize_products.to_s}")
      if prize_products.count > 0
        pc.has_bonus = true
        pc.bonus_text = ''
        pc.bonus_updated_at = now_date
        prize_products.each_with_index do |prize_product, index|
          separator = (index == 0) ? '': ', '
          # !!! ONLY FOR ONE BONUS PRODUCT AND 1 PCS
          first_bonus_product_id = prize_product['conditions']['bonus_products'][0]['id'].to_i
          first_bonus_product_name = PosterProduct.where(product_id: first_bonus_product_id).first.product_name
          # Logger.new('log/resque.log').info("PosterIntegration first_bonus_product_name #{first_bonus_product_name}")
          # first_bonus_product_pcs = prize_product['conditions']['bonus_products_pcs'].to_s
          text = separator + first_bonus_product_name + ' - 1 ' + I18n.t(:pcs)
          pc.bonus_text += text
        end
        Logger.new('log/resque.log').info("PosterIntegration prize_products.count > 0 pc.bonus_text #{pc.bonus_text}")
      else
        pc.has_bonus = false
        pc.bonus_text = 'no bonus'
        pc.bonus_updated_at = now_date
      end
      pc.save
    end
  end

  def get_products
    Rails.logger.info("start get_products")
    url = account_url + 'menu.getProducts?format=json&token=' + token
    Rails.logger.info("url #{url}")
    res = URI.parse(url).read
    @poster_products = JSON.parse(res)
    Rails.logger.info("@poster_products #{@poster_products}")
  end

  # saving poster_products
  def persist_products
    products_arr = poster_products['response']
    Logger.new('log/resque.log').info("PosterIntegration products_arr.to_s #{products_arr.to_s}")
    products_arr.each do |prod|
      product = PosterProduct.new(product_id: prod['product_id'], product_name: prod['product_name'])
      Logger.new('log/resque.log').info("product #{product.to_json}")
      product.save!
    end 
  end

  private

  def token
    return ENV["poster_token"].to_s
  end

  def account_url
    return 'https://busation.joinposter.com/api/'
  end

end
