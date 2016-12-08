class YandexKassaController < ApplicationController
  # protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token
  # POST
  def order_check
  	Rails.logger.info("YandexKassaController order_check begin")
  	shopSumAmount = params[:shopSumAmount]
   	Rails.logger.info("YandexKassaController shopSumAmount #{shopSumAmount}")
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.checkOrderResponse(
        'performedDatetime' => '2011-05-04T20:38:01.000+04:00',
        'code' => '0',
        'invoiceId' => '2000000907465',
        'shopId' => '88596')
    end
    render xml: builder.to_xml
   	# data={
   	# 	:performedDatetime=>'2011-05-04T20:38:01.000+04:00',
   	# 	:code=>0, 
   	# 	:invoiceId=>2000000907465,
   	# 	:shopId=>88596}
    # render xml: data.to_xml(root: "checkOrderResponse")
  end
end
