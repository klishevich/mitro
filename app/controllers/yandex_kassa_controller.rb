class YandexKassaController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def order_success
    @orderSumAmount = params[:orderSumAmount]
  end

  def order_fail
  end

  # POST
  def order_check
    Rails.logger.info("----- YandexKassaController order_check begin -----")
    code = calc_fault_code(params)
    now_date = DateTime.now
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.checkOrderResponse(
        'performedDatetime' => now_date,
        'code' => code,
        'invoiceId' => params[:invoiceId],
        'shopId' => params[:shopId])
    end
    Rails.logger.info("----- YandexKassaController order_check end -----")
    render xml: builder.to_xml
  end

  # POST
  def order_payment_aviso
    Rails.logger.info("----- YandexKassaController order_payment_aviso begin -----")
    code = calc_fault_code(params)
    if code == "0"
      order_id = params[:customerNumber].to_i
      order = Order.find_by_id(order_id)
      order.order_payed_yandex_kassa
      order.save
    end
    now_date = DateTime.now
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.paymentAvisoResponse(
        'performedDatetime' => now_date,
        'code' => code,
        'invoiceId' => params[:invoiceId],
        'shopId' => params[:shopId])
    end
    Rails.logger.info("----- YandexKassaController order_payment_aviso end -----")
    render xml: builder.to_xml
  end

  private
  def calc_fault_code(params)
    # code ошибки
    code = ""
    Rails.logger.info("--- YandexKassaController serve_callback begin ---")
    action = params[:action]
    orderSumAmount = params[:orderSumAmount]
    orderSumCurrencyPaycash = params[:orderSumCurrencyPaycash]
    orderSumBankPaycash = params[:orderSumBankPaycash]
    shopId = params[:shopId]
    invoiceId = params[:invoiceId]
    # customerNumber is order.id
    customerNumber = params[:customerNumber]
    md5_client = params[:md5]
    
    if action && orderSumAmount && orderSumCurrencyPaycash && orderSumBankPaycash && shopId && invoiceId && customerNumber && md5_client
      # code="0" all ok
      code = "0"
      Rails.logger.info("action #{action}")
      Rails.logger.info("orderSumAmount #{orderSumAmount}")
      Rails.logger.info("orderSumCurrencyPaycash #{orderSumCurrencyPaycash}")
      Rails.logger.info("orderSumBankPaycash #{orderSumBankPaycash}")
      Rails.logger.info("shopId #{shopId}")
      Rails.logger.info("invoiceId #{invoiceId}")
      Rails.logger.info("customerNumber #{customerNumber}")
      Rails.logger.info("md5_client #{md5_client}")
    else
      # code="200" - parameters not defined
      code = "200"
    end
    
    orderSumAmount_server = '0.00'
    if code == "0"
      order = Order.find_by_id(customerNumber.to_i)
      if order 
        Rails.logger.info("order #{order.to_json}")
        orderSumAmount_server = '%.2f' % order.total_sum
        Rails.logger.info("orderSumAmount_server #{orderSumAmount_server}")
      else
        # code = "100" order not found
        code = "100"
      end
    end

    if code == "0"
      md5_server = Digest::MD5.new
      shopPassword = ENV["yandex_kassa_shop_password"].to_s
      md5_server_string = action + ";" + orderSumAmount_server + ";" + orderSumCurrencyPaycash + ";" + orderSumBankPaycash + ";" + shopId + ";" + invoiceId + ";" + customerNumber + ";" + shopPassword
      Rails.logger.info("md5_server_string #{md5_server_string}")
      md5_server << md5_server_string
      # md5_server << action << orderSumAmount_server << orderSumCurrencyPaycash << orderSumBankPaycash << shopId << invoiceId << customerNumber << shopPassword
      md5_server_up = md5_server.to_s.upcase
      Rails.logger.info("md5_server_up #{md5_server_up}")
      if md5_client != md5_server
        # code="1" MD5 does not match
        # code = "1" MD5 CHECK IS SWITCHED OFF
        code = "0"
      end
    end
    Rails.logger.info("code #{code}")
    Rails.logger.info("--- YandexKassaController serve_callback end ---")
    return code
  end

end
