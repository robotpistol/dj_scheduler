# frozen_string_literal: true

require 'sequel'

# 'create links'
Sequel.migration do
  change do
    create_table :djs do
      primary_key :id

      String :name, null: false
      String :email, unique: true, null: false

      DateTime :created_at
    end

    create_table :dance_dates do
      primary_key :id

      Date :date, unique: true, null: false

      String :additional_detail
      index :date
    end

    create_table :availabilities do
      foreign_key :dj_id, :djs, null: false
      foreign_key :dance_date_id, :dance_dates, null: false

      String :status

      index :dance_date_id
    end

    create_table :emails do
      foreign_key :dj_id, :djs, null: false
      Date :period_start, null: false
      Date :period_end, null: false
      String :token, unique: true, null: false

      index :token
    end
  end
end
