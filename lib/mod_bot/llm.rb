# frozen_string_literal: true

require 'openai'
require 'anthropic'

module ModBot
  module LLM
    def self.ask(prompt, model: nil)
      model ||= ModBot::Config.model
      if model&.downcase&.include?('claude')
        client = ::Anthropic::Client.new(api_key: ModBot::Config.anthropic_api_key)
        response = client.completions.create(
          model: model,
          prompt: prompt,
          max_tokens_to_sample: 256
        )
        response.completion.strip
      else
        client = ::OpenAI::Client.new(access_token: ModBot::Config.openai_api_key)
        response = client.chat(parameters: {
                                 model: model,
                                 messages: [{ role: 'user', content: prompt }],
                                 max_tokens: 256
                               })
        response.dig('choices', 0, 'message', 'content').to_s.strip
      end
    end
  end
end
