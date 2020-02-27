class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://blockdelta.com/login'
    mail(to: @user.email, subject: 'Welcome to Blockdelta')
  end
  def forgot_password(user)
    @user = user
    @url  = 'http://blockdelta.com/password-reset/'
    mail(to: @user.email, subject: 'Reset password instructions')
  end
end
