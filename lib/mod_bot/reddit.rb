# frozen_string_literal: true

require_relative 'events/post_event'
require_relative 'events/comment_event'
require_relative 'events/report_event'

module ModBot
  module Reddit
    @event_handlers = {
      post: [],
      comment: [],
      report: []
    }

    def self.start_polling(subreddit:, interval: 30)
      require 'redd'
      client = Redd.it(
        user_agent: 'modbot',
        client_id: ModBot::Config.reddit_client_id,
        secret: ModBot::Config.reddit_secret,
        username: ModBot::Config.reddit_username,
        password: ModBot::Config.reddit_password
      )
      seen_posts = Set.new
      seen_comments = Set.new
      loop do
        # Posts
        client.subreddit(subreddit).new(limit: 10).each do |post|
          next if seen_posts.include?(post.id)

          seen_posts << post.id
          @event_handlers[:post].each do |event|
            ai_response = ModBot::LLM.ask(event.prompt + "\n" + post.title.to_s + "\n" + post.selftext.to_s)
            event.handler.call(post, ai_response)
          end
        end
        # Comments
        client.subreddit(subreddit).comments(limit: 10).each do |comment|
          next if seen_comments.include?(comment.id)

          seen_comments << comment.id
          @event_handlers[:comment].each do |event|
            ai_response = ModBot::LLM.ask(event.prompt + "\n" + comment.body.to_s)
            event.handler.call(comment, ai_response)
          end
        end
        sleep interval
      end
    end

    class << self
      # Register a post event for Reddit
      def on_post(subreddit:, prompt:, interval: '5m', &block)
        register_event(
          platform: 'reddit',
          resource_type: 'subreddit',
          resource: subreddit,
          event_type: 'post',
          prompt: prompt,
          interval: interval,
          handler: block
        )
      end

      # Register a comment event for Reddit
      def on_comment(subreddit:, prompt:, interval: '5m', &block)
        register_event(
          platform: 'reddit',
          resource_type: 'subreddit',
          resource: subreddit,
          event_type: 'comment',
          prompt: prompt,
          interval: interval,
          handler: block
        )
      end

      # Register a report event for Reddit
      def on_report(subreddit:, prompt:, interval: '5m', &block)
        register_event(
          platform: 'reddit',
          resource_type: 'subreddit',
          resource: subreddit,
          event_type: 'report',
          prompt: prompt,
          interval: interval,
          handler: block
        )
      end

      # Generic event registration for any platform (in-memory only)
      def register_event(platform:, resource_type:, resource:, event_type:, prompt:, interval:, handler:)
        @event_handlers[event_type.to_sym] << OpenStruct.new(
          platform: platform,
          resource_type: resource_type,
          resource: resource,
          event_type: event_type.to_s,
          prompt: prompt,
          interval: interval,
          handler: handler
        )
      end

      def event_handlers
        @event_handlers
      end
    end
  end
end
