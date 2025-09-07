# frozen_string_literal: true

require 'spec_helper'
require 'mod_bot/config'

describe ModBot::Config do
  it 'allows setting and getting config values' do
    ModBot::Config.reddit_client_id = 'abc'
    expect(ModBot::Config.reddit_client_id).to eq('abc')
  end
end
