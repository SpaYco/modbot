# frozen_string_literal: true

require 'spec_helper'
require 'modbot/llm'

RSpec.describe ModBot::LLM do
  it 'selects OpenAI for non-claude models' do
    expect(ModBot::LLM.ask('test', model: 'gpt-4')).to eq('AI response')
  end

  it 'selects Anthropic for claude models' do
    expect(ModBot::LLM.ask('test', model: 'claude-3')).to eq('Claude response')
  end
end
