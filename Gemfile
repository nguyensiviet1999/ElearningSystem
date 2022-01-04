source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"
gem "bootstrap-sass"
gem "bcrypt"
gem "rufo"
gem "ransack"
gem "omniauth-google-oauth2"
gem "omniauth-facebook"
gem "redis"
#phan trang voi array
gem "pagy"
gem "jquery-countdown-rails"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0.3", ">= 6.0.3.2"
# Use sqlite3 as the database for Active Record
gem "jquery-rails"
gem "popper_js"
# Use Puma as the app server
gem "puma", "~> 4.1"
# Use SCSS for stylesheets
gem "sass-rails", ">= 6"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "~> 4.0"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem "uglifier"
gem "coffee-rails"
gem "faker"
gem "will_paginate"
gem "bootstrap-will_paginate"
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false
gem "sendgrid-ruby"
#GEM LOAD ANH
gem "carrierwave"
gem 'mimemagic', '~> 0.3.10'
gem "fog"
gem "devise"
gem "config"
gem 'mysql2', '~> 0.5.2'
gem 'rails-i18n'
gem 'rubocop', require: false
group :development, :test do
  gem "sqlite3", "1.4.2"
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "rspec-rails"
  gem "rspec-expectations"
  gem "factory_bot_rails"
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-sidekiq'
  gem 'capistrano3-puma'
  gem 'slack-ruby-client'
  gem 'letter_opener'
end

group :test do
  gem "shoulda-matchers"
  gem "rails-controller-testing"
  gem "minitest-reporters"
  gem "guard"
  gem "guard-minitest"
  # Adds support for Capybara system testing and selenium driver
  gem "capybara"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end
group :production do
  gem "pg"
  gem 'mysql2', '~> 0.5.2'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
