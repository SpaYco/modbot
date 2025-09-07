# frozen_string_literal: true

module Support
  module RedditMock
    def self.client
      # Return a plain Ruby object with subreddit method
      Class.new do
        def subreddit(_)
          Class.new do
            def new(*)
              []
            end

            def comments(*)
              []
            end
          end.new
        end
      end.new
    end
  end
end
