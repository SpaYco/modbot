# frozen_string_literal: true

require 'sequel'

module ModBot
  module DB
    def self.connect(url = nil)
      url ||= ENV['MODBOT_DATABASE_URL'] || 'postgres://localhost/modbot'
      @db = Sequel.connect(url)
    end

    def self.db
      @db ||= connect
    end
  end
end
