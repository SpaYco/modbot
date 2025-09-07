# frozen_string_literal: true

module Support
  module OpenAIMock
    def self.client
      # Return a plain Ruby object with a #chat method
      Class.new do
        def chat(*)
          { 'choices' => [{ 'message' => { 'content' => 'AI response' } }] }
        end
      end.new
    end
  end
end
