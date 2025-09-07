# frozen_string_literal: true

module ModBot
  module Config
    class << self
      attr_accessor :reddit_client_id, :reddit_secret, :reddit_username, :reddit_password, :openai_api_key,
                    :anthropic_api_key, :model
    end
  end
end
