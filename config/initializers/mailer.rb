Rails.configuration.action_mailer.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'gmail.com',
  user_name:            Rails.application.secrets.smtp[:user_name],
  password:             Rails.application.secrets.smtp[:password],
  authentication:       'plain',
  enable_starttls_auto: true
}
