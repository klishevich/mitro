class UserMailer < ApplicationMailer
  
  def welcome_email(user)
    @user = user
    @url  = 'http://mitro.j123.ru/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to MITROFOOD')
  end

end
