class YandexKassaController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # POST
  # action, orderSumAmount, orderSumCurrencyPaycash, orderSumBankPaycash, 
  # shopId, invoiceId, customerNumber, MD5
  def order_check
  	Rails.logger.info("--- YandexKassaController order_check begin ---")
  	action = params[:action]
    orderSumAmount = params[:orderSumAmount]
    orderSumCurrencyPaycash = params[:orderSumCurrencyPaycash]
    orderSumBankPaycash = params[:orderSumBankPaycash]
    shopId = params[:shopId]
    invoiceId = params[:invoiceId]
    customerNumber = params[:customerNumber]
    vMD5 = params[:MD5]
   	Rails.logger.info("action #{action}")
    Rails.logger.info("orderSumAmount #{orderSumAmount}")
    Rails.logger.info("orderSumCurrencyPaycash #{orderSumCurrencyPaycash}")
    Rails.logger.info("orderSumBankPaycash #{orderSumBankPaycash}")
    Rails.logger.info("shopId #{shopId}")
    Rails.logger.info("invoiceId #{invoiceId}")
    Rails.logger.info("customerNumber #{customerNumber}")
    Rails.logger.info("MD5 #{vMD5}")
    # !!! make md5 check
    # MD5(action;MY_ORDER_SUM;orderSumCurrencyPaycash;orderSumBankPaycash;shopId;invoiceId;customerNumber;shopPassword);
    now_date = Time.now
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.checkOrderResponse(
        'performedDatetime' => now_date,
        'code' => '0',
        'invoiceId' => invoiceId,
        'shopId' => shopId)
    end
    Rails.logger.info("--- YandexKassaController order_check end ---")
    render xml: builder.to_xml
  end

  # POST
  def order_payment_aviso
    Rails.logger.info("--- YandexKassaController order_payment_aviso begin ---")
    action = params[:action]
    orderSumAmount = params[:orderSumAmount]
    orderSumCurrencyPaycash = params[:orderSumCurrencyPaycash]
    orderSumBankPaycash = params[:orderSumBankPaycash]
    shopId = params[:shopId]
    invoiceId = params[:invoiceId]
    customerNumber = params[:customerNumber]
    vMD5 = params[:MD5]
    # !!! make md5 check
    Rails.logger.info("action #{action}")
    Rails.logger.info("orderSumAmount #{orderSumAmount}")
    Rails.logger.info("orderSumCurrencyPaycash #{orderSumCurrencyPaycash}")
    Rails.logger.info("orderSumBankPaycash #{orderSumBankPaycash}")
    Rails.logger.info("shopId #{shopId}")
    Rails.logger.info("invoiceId #{invoiceId}")
    Rails.logger.info("customerNumber #{customerNumber}")
    Rails.logger.info("MD5 #{vMD5}")
    now_date = Time.now
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.paymentAvisoResponse(
        'performedDatetime' => now_date,
        'code' => '0',
        'invoiceId' => invoiceId,
        'shopId' => shopId)
    end
    Rails.logger.info("--- YandexKassaController order_payment_aviso end ---")
    render xml: builder.to_xml
  end
end
