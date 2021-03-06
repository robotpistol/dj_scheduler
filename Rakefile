# frozen_string_literal: true

require 'sequel'
require 'yaml'

ENV['RACK_ENV'] ||= 'dev'
database = ENV['DATABASE_URL']
if database.nil?

  config_file_path = File.read(File.join(File.dirname(__FILE__), '../config/database.yml'))
  database_creds = YAML.safe_load(config_file_path, [], [], true)
  config_key = "dj_scheduler_db_#{ENV['RACK_ENV']}"
  database = database_creds[config_key]
end

raise 'Problem loading db config!' unless database

puts database.inspect

namespace :db do
  namespace :migrate do
    Sequel.extension :migration
    DB = Sequel.connect(database)

    desc 'Perform migration reset (full erase and migration up)'
    task :reset do
      Sequel::Migrator.run(DB, 'migrations', target: 0)
      Sequel::Migrator.run(DB, 'migrations')
      puts '<= sq:migrate:reset executed'
    end

    desc 'Perform migration up/down to VERSION'
    task :to do
      version = ENV['VERSION'].to_i
      raise 'No VERSION was provided' if version.nil?

      Sequel::Migrator.run(DB, 'migrations', target: version)
      puts "<= sq:migrate:to version=[#{version}] executed"
    end

    desc 'Perform migration up to latest migration available'
    task :up do
      Sequel::Migrator.run(DB, 'migrations')
      puts '<= sq:migrate:up executed'
    end

    desc 'Perform migration down (erase all data)'
    task :down do
      Sequel::Migrator.run(DB, 'migrations', target: 0)
      puts '<= sq:migrate:down executed'
    end
  end
  task migrate: 'migrate:up'
end
