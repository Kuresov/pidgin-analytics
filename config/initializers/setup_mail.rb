if Rails.env.development?
  ActionMailer::Base.smtp_settings = {
    address: 'localhost',
    port:    25,
    domain:  'google.com'
  }
end
