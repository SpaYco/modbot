# Needed for OpenStruct in mocks
require "ostruct"
# frozen_string_literal: true

# No DB setup needed; only mocks and RSpec config remain.
require 'base64'
require 'rspec'
require 'redd'
require 'openai'
require 'anthropic'
require_relative 'support/reddit_mock'
require_relative 'support/openai_mock'
require_relative 'support/anthropic_mock'

RSpec.configure do |config|
  config.before(:each) do
    # Use plain Ruby object mocks
    allow(OpenAI::Client).to receive(:new).and_return(Support::OpenAIMock.client)
    allow(Anthropic::Client).to receive(:new).and_return(Support::AnthropicMock.client)
    allow(Redd).to receive(:it).and_return(Support::RedditMock.client)
  end
end
