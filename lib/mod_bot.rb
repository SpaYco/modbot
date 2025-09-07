# frozen_string_literal: true

# Main entry point for the ModBot gem
require 'base64'
require 'redd'
require 'openai'
require 'anthropic'
require 'ostruct'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module ModBot
  def self.configure
    yield(Config)
  end
end
