source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
#gem 'pg', '0.14.0'

# https://devcenter.heroku.com/articles/rails4
gem 'rails_12factor', group: :production

#group :assets do
	# Use SCSS for stylesheets
	gem 'sass-rails', '~> 4.0.0'
	# Use Uglifier as compressor for JavaScript assets
	gem 'uglifier', '>= 1.3.0'
	# Use CoffeeScript for .js.coffee assets and views
	gem 'coffee-rails', '~> 4.0.0'
	# http://railscasts.com/episodes/328-twitter-bootstrap-basics?view=asciicast
	gem 'twitter-bootstrap-rails'
	gem 'therubyracer'
	gem 'less-rails'
	gem 'less-rails-bootstrap'
	gem 'libv8'
#end
gem 'pg'
gem 'devise'
gem 'nested_form'
gem 'kaminari'
gem "mail"
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# http://asciicasts.com/episodes/234-simple-form
# https://github.com/plataformatec/simple_form
# https://github.com/justinfrench/formtastic
#gem 'simple_form'
gem 'formtastic'
# https://github.com/mjbellantoni/formtastic-bootstrap
gem 'formtastic-bootstrap'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

#group :development do
#  gem 'webrick', '~> 1.3.1'
#end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
group :development, :test do
  gem 'rspec-rails'
  gem 'debugger'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
end

ruby "2.0.0"
