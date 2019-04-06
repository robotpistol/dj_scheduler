# frozen_string_literal: true

require 'sequel'
require 'sinatra'

class DJ < Sequel::Model
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  def validate
    super
    errors.add(:name, 'cannot be empty') if !name || name.empty?
    if !email || email.empty?
      errors.add(:email, 'cannot be empty')
    elsif !VALID_EMAIL_REGEX.match(email)
      errors.add(:email, 'Email does not match email address')
    end
  end
end

class DanceDate < Sequel::Model
  def validate
    super
    errors.add(:date, 'cannot be empty') if !name || name.empty?
    errors.add(:url, 'cannot be empty') if !url || url.empty?
  end
end

class Availability < Sequel::Model
  VALID_STATUSES = %w[yes no maybe].freeze

  def validate
    super
    errors.add(:dj_id, 'cannot be empty') unless dj_id
    errors.add(:dance_date_id, 'cannot be empty') unless dance_date_id
    errors.add(:status, 'invalid status') if VALID_STATUSES.memeber?(status)
  end
end

get '/' do
  'Hello!'
end
