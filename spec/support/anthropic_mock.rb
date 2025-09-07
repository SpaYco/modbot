# frozen_string_literal: true

module Support
  module AnthropicMock
    def self.client
      # Return a plain Ruby object with a #completions method
      Class.new do
        def completions
          Class.new do
            def create(*)
              OpenStruct.new(completion: 'Claude response')
            end
          end.new
        end
      end.new
    end
  end
end
