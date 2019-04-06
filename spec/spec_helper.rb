# frozen_string_literal: true

# spec/spec_helper.rb
require 'rack/test'
require 'rspec'
require 'yaml'
require 'sequel'

ENV['RACK_ENV'] = 'test'
database = ENV['DATABASE_URL']
puts database.inspect
if database.nil?
  config_file_path = File.read(File.join(File.dirname(__FILE__), '../config/database.yml'))
  database_creds = YAML.safe_load(config_file_path, [], [], true)
  database = database_creds['dj_scheduler_db_test']
end

DB = Sequel.connect(database)

require File.expand_path '../app.rb', __dir__

module RSpecMixin
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
end

RSpec.configure do |c|
  c.around(:each) do |example|
    DB.transaction(rollback: :always, auto_savepoint: true) { example.run }
  end

  c.include RSpecMixin
end
