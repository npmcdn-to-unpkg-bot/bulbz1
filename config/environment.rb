# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


if Rails.env.development?
CREDENTIALS = YAML.load_file(Rails.root.join('config','email.yml'))
end


SK_EMAIL = Rails.env.development? ? CREDENTIALS['username'] : ENV['SK_EMAIL']
SK_PASSWORD = Rails.env.development? ? CREDENTIALS['password'] : ENV['SK_PASSWORD']


ActionMailer::Base.smtp_settings = {
  user_name: SK_EMAIL,
  password: SK_PASSWORD,
  address: 'smtp.gmail.com',
  port: 587,
  authentication: 'plain',
  enable_starttls_auto: true
}
