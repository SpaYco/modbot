# frozen_string_literal: true

# Require external gems for global availability
require 'base64'
require 'redd'
require 'openai'
require 'anthropic'
require 'sequel'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module ModBot
  def self.configure
    yield(Config)
  end
end
