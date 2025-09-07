# Needed for OpenStruct in mocks
require "ostruct"
# frozen_string_literal: true

# Migrate test DB before loading models
require_relative 'support/db_migrate'

require 'base64'
require 'rspec'
require 'redd'
require 'openai'
require 'anthropic'
require_relative 'support/reddit_mock'
require_relative 'support/openai_mock'
require_relative 'support/anthropic_mock'

require 'modbot/db'
ModBot::DB.connect(ENV['MODBOT_DATABASE_URL'] || 'postgres://localhost/modbot_test')
require 'modbot/models'

RSpec.configure do |config|
  config.before(:each) do
    # Use plain Ruby object mocks
    allow(OpenAI::Client).to receive(:new).and_return(Support::OpenAIMock.client)
    allow(Anthropic::Client).to receive(:new).and_return(Support::AnthropicMock.client)
    allow(Redd).to receive(:it).and_return(Support::RedditMock.client)
    # Clean up all tables before each test
    if defined?(ModBot::Models::Event) && defined?(ModBot::Models::SeenItem)
      ModBot::Models::Event.dataset.truncate
      ModBot::Models::SeenItem.dataset.truncate
    end
  end
end
