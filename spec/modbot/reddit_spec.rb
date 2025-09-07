# frozen_string_literal: true

require 'spec_helper'
require 'modbot/reddit'

describe ModBot::Reddit do
  before(:each) do
    ModBot::Models::Event.dataset.delete
  end

  it "registers post events in the database" do
  handler = proc { |p, r| }
  allow(Marshal).to receive(:dump).and_return("handler-dump")
  allow(Marshal).to receive(:load).and_return(handler)
  ModBot::Reddit.on_post(subreddit: "testsub", prompt: "test", interval: "5m", &handler)
  event = ModBot::Models::Event.last
  expect(event).not_to be_nil
  expect(event.platform).to eq("reddit")
  expect(event.resource_type).to eq("subreddit")
  expect(event.resource).to eq("testsub")
  expect(event.event_type).to eq("post")
  expect(Marshal.load(event.handler_code)).to eq(handler)
  end

  it "registers comment events in the database" do
  handler = proc { |c, r| }
  allow(Marshal).to receive(:dump).and_return("handler-dump")
  allow(Marshal).to receive(:load).and_return(handler)
  ModBot::Reddit.on_comment(subreddit: "testsub", prompt: "test", interval: "5m", &handler)
  event = ModBot::Models::Event.last
  expect(event).not_to be_nil
  expect(event.platform).to eq("reddit")
  expect(event.resource_type).to eq("subreddit")
  expect(event.resource).to eq("testsub")
  expect(event.event_type).to eq("comment")
  end

  it "registers report events in the database" do
  handler = proc { |r, a| }
  allow(Marshal).to receive(:dump).and_return("handler-dump")
  allow(Marshal).to receive(:load).and_return(handler)
  ModBot::Reddit.on_report(subreddit: "testsub", prompt: "test", interval: "5m", &handler)
  event = ModBot::Models::Event.last
  expect(event).not_to be_nil
  expect(event.platform).to eq("reddit")
  expect(event.resource_type).to eq("subreddit")
  expect(event.resource).to eq("testsub")
  expect(event.event_type).to eq("report")
  end
end
