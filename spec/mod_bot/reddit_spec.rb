# frozen_string_literal: true

require 'spec_helper'
require 'mod_bot/reddit'

describe ModBot::Reddit do
  before(:each) do
    # Reset in-memory event handlers
    ModBot::Reddit.instance_variable_set(:@event_handlers, {
                                           post: [],
                                           comment: [],
                                           report: []
                                         })
  end

  it 'registers post events in memory' do
    handler = proc { |p, r| }
    ModBot::Reddit.on_post(subreddit: 'testsub', prompt: 'test', interval: '5m', &handler)
    event = ModBot::Reddit.event_handlers[:post].last
    expect(event).not_to be_nil
    expect(event.platform).to eq('reddit')
    expect(event.resource_type).to eq('subreddit')
    expect(event.resource).to eq('testsub')
    expect(event.event_type).to eq('post')
    expect(event.handler).to eq(handler)
  end

  it 'registers comment events in memory' do
    handler = proc { |c, r| }
    ModBot::Reddit.on_comment(subreddit: 'testsub', prompt: 'test', interval: '5m', &handler)
    event = ModBot::Reddit.event_handlers[:comment].last
    expect(event).not_to be_nil
    expect(event.platform).to eq('reddit')
    expect(event.resource_type).to eq('subreddit')
    expect(event.resource).to eq('testsub')
    expect(event.event_type).to eq('comment')
    expect(event.handler).to eq(handler)
  end

  it 'registers report events in memory' do
    handler = proc { |r, a| }
    ModBot::Reddit.on_report(subreddit: 'testsub', prompt: 'test', interval: '5m', &handler)
    event = ModBot::Reddit.event_handlers[:report].last
    expect(event).not_to be_nil
    expect(event.platform).to eq('reddit')
    expect(event.resource_type).to eq('subreddit')
    expect(event.resource).to eq('testsub')
    expect(event.event_type).to eq('report')
    expect(event.handler).to eq(handler)
  end
end
