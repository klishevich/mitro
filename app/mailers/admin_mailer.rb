class AdminMailer < ApplicationMailer

  def new_order(order)
    @order = order
    mail(to: adm_email, subject: 'MITROFOOD: new order')
  end

  private
  
  def adm_email
  	'm.klishevich@yandex.ru'
  end

end
