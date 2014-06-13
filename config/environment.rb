# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Gida::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :domain         => 'mail.google.com',
  :port           => 1025,
  :user_name      => 'rajput.umakant4@gmail.com',
  :password       => 'umakant05',
  :authentication => :plain,
  :enable_starttls_auto => true
}
