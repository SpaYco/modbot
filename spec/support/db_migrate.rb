# frozen_string_literal: true

require 'sequel'
Sequel.extension :migration
test_url = ENV['MODBOT_TEST_DATABASE_URL'] || ENV['MODBOT_DATABASE_URL'] || 'postgres://localhost/modbot_test'
db = Sequel.connect(test_url)
Sequel::Migrator.run(db, File.expand_path('../../db/migrate', __dir__))
