ActionMailer::Base.delivery_method = :smtp # be sure to choose SMTP delivery
ActionMailer::Base.smtp_settings = {
  :address              => "mail.blockdelta.com",
  :port                 => 465,
  :domain               => "blockdelta.com",
  :user_name            => "no-reply@humouno.com",
  :password             => "EI~6QHThtysz",
  :authentication       => "login",
  :enable_starttls_auto => true
}