source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.4'
gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'figaro'
gem 'devise'
gem 'jquery-rails'
gem 'simple_form'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'geocoder'
gem 'bootstrap', '~> 4.1.1'
gem 'active_link_to'
gem 'country_select'
gem 'mini_magick'
gem 'aws-sdk-s3', require: false
gem 'turbolinks'
gem 'sendgrid-ruby'
gem 'tinymce-rails'
gem 'stripe'
gem 'rollbar'
gem 'rubocop', '~> 0.58.2', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'chromedriver-helper'
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
  gem 'rspec-rails', '~> 3.7'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'guard'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-bundler'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
end

group :test do
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'capybara-email'
  gem 'selenium-webdriver'
  gem 'launchy'
  gem 'webmock'
  gem 'stripe-ruby-mock', '~> 2.5.4', :require => 'stripe_mock'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
