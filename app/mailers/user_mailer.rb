class UserMailer < ApplicationMailer
    default from: 'no-reply@blockdelta.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://blockdelta.com/auth/login'
    mail(to: @user.email, subject: 'Welcome to Blockdelta')
  end
  def forgot_password(user)
    @user = user
    @url  = 'http://blockdelta.com/password-reset/'
    mail(to: @user.email, subject: 'Reset password instructions')
  end
  def user_approved (user)
    @user = user
    @url  = 'http://blockdelta.com/auth/login'
    mail(to: @user.email, subject: 'Blockdelta aproved')
  end
end
