# frozen_string_literal: true

# spec/app_spec.rb
require File.expand_path 'spec_helper.rb', __dir__

describe 'DJ Scheduler' do
  it 'allows accessing the home page' do
    get '/'

    expect(last_response).to be_ok
  end
end
