# Load the Rails application.
require File.expand_path('../application', __FILE__)
require 'smtp_tls'

# Initialize the Rails application.
Gida::Application.initialize!
ENV['SSL_CERT_FILE'] = '/path/to/your/new/cacert.pem'
