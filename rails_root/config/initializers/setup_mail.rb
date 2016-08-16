if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:        'smtp.mandrillapp.com',
    port:           '587',
    authentication: :plain,
    user_name:      Rails.application.secrets.mandrill_username,
    password:       Rails.application.secrets.mandrill_password,
    domain:         'heroku.com',
    enable_starttls_auto: true
  }
end
