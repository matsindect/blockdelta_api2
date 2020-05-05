ActionMailer::Base.delivery_method = :smtp # be sure to choose SMTP delivery
ActionMailer::Base.smtp_settings = {
  :address              => "mail.blockdelta.com",
  :port                 => 587,
  :domain               => "blockdelta.com",
  :user_name            => "no-reply@blockdelta.com",
  :password             => "EI~6QHThtysz",
  :authentication       => "login",
  :enable_starttls_auto => true,
  :openssl_verify_mode  => 'none'
}