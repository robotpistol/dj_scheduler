# frozen_string_literal: true

require 'sequel'
require 'yaml'

ENV['RACK_ENV'] ||= 'dev'

database_creds = YAML.safe_load(File.read(File.join(File.dirname(__FILE__), 'config/database.yml')))
database = database_creds["dj_scheduler_db_#{ENV['RACK_ENV']}"]

DB = Sequel.connect(database)

require './app'

run Sinatra::Application
