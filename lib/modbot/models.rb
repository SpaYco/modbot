# frozen_string_literal: true

require 'sequel'
require_relative 'db'

module ModBot
  module Models
    class Event < Sequel::Model(:events)
      # platform: 'reddit', 'facebook', etc.
      # resource_type: 'subreddit', 'page', etc.
      # resource: subreddit name, page id, etc.
      # event_type: 'post', 'comment', 'tweet', etc.
    end

    class SeenItem < Sequel::Model(:seen_items)
      # platform, resource_type, resource, item_id, event_type
    end
  end
end
