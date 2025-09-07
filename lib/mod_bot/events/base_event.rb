# frozen_string_literal: true

module ModBot
  module Events
    class BaseEvent
      attr_reader :prompt, :handler

      def initialize(prompt, handler)
        @prompt = prompt
        @handler = handler
      end
    end
  end
end
