source 'https://rubygems.org'

ruby "2.1.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# required for flat ui kit
#gem 'compass-rails', '~> 2.0.4'
#gem 'rake', '10.4.2'
gem 'rake', '11.2.2'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Fixes issue with warnings
gem 'thor', '= 0.19.1'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# for PDF generation
gem 'prawn', '~> 2.1'

#gem 'foundation-icons-sass-rails'
#gem 'foundation-rails', '~> 5.5.2.1'

gem 'slim', '~> 3.0', '>= 3.0.7'
gem 'susy', '~> 2.2', '>= 2.2.12'
gem 'normalize-rails', '~> 4.1', '>= 4.1.1'
gem 'breakpoint', '~> 2.7'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.1'

gem 'simple_form'

gem 'enum_help'

#gem 'sweet-alert'
#gem 'sweet-alert-confirm'

gem 'devise'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'puma'
  gem 'pg'
  gem 'rails_12factor'
end
