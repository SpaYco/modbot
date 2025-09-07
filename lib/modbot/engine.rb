# frozen_string_literal: true

require 'rails/engine'

module ModBot
  class Engine < ::Rails::Engine
    isolate_namespace ModBot

    initializer 'modbot.load' do
      # Optionally, load Sequel or other config here
      ModBot.configure_for_rails! if ModBot.respond_to?(:configure_for_rails!)
    end
  end
end
