# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |_repo_name| 'https://github.com/robotpistol/dj_scheduler' }

gem 'pg'
gem 'unicorn'
gem 'rake'
gem 'sequel'
gem 'sinatra', '~> 2.0.0'
gem 'sinatra-contrib'
gem 'sinatra-sequel'

group :test, :development do
  gem 'rubocop'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'sqlite3'
end
