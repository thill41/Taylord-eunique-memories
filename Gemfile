source 'https://rubygems.org'

ruby '3.3.3'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.2.1'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.5'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 4.0.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 3.2'
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
end

group :development do
  gem 'rubocop-capybara'
  gem 'rubocop-factory_bot'
  gem 'rubocop-rails', require: false
  gem 'rubocop-shopify'
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-asdf', '~> 1.1'
end

group :test do
  gem 'mocha'
  gem 'shoulda', '~> 4.0'
  gem 'shoulda-matchers', '~> 4.0'
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end

gem 'active_storage_validations'
gem 'cssbundling-rails', '~> 1.4'
gem 'devise', '~> 4.9'
gem 'mini_magick'
# Needed until Ruby 3.3.4 is released https://github.com/ruby/ruby/pull/11006
gem 'net-pop', github: 'ruby/net-pop'
gem 'pundit', '~> 2.4.0'
gem 'sassc-rails'
gem 'sidekiq'
gem 'will_paginate'
