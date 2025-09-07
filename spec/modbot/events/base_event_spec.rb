# frozen_string_literal: true

require 'spec_helper'
require 'modbot/events/base_event'

describe ModBot::Events::BaseEvent do
  it 'stores prompt and handler' do
    handler = proc { |x| x }
    event = described_class.new('prompt', handler)
    expect(event.prompt).to eq('prompt')
    expect(event.handler).to eq(handler)
  end
end
