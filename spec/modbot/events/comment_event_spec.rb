# frozen_string_literal: true

require 'spec_helper'
require 'modbot/events/comment_event'

describe ModBot::Events::CommentEvent do
  it 'inherits from BaseEvent' do
    expect(described_class < ModBot::Events::BaseEvent).to be true
  end
end
