# frozen_string_literal: true

require 'spec_helper'
require 'mod_bot/events/report_event'

describe ModBot::Events::ReportEvent do
  it 'inherits from BaseEvent' do
    expect(described_class < ModBot::Events::BaseEvent).to be true
  end
end
