# frozen_string_literal: true

require_relative 'lib/modbot/db'

namespace :db do
  desc 'Run all migrations'
  task :migrate do
    Sequel.extension :migration
    Sequel::Migrator.run(ModBot::DB.db, 'db/migrate')
    puts 'Migrations complete.'
  end

  desc 'Run all migrations on the test database'
  task :"migrate:test" do
    Sequel.extension :migration
    test_url = ENV['MODBOT_TEST_DATABASE_URL'] || ENV['MODBOT_DATABASE_URL'] || 'postgres://localhost/modbot_test'
    db = Sequel.connect(test_url)
    Sequel::Migrator.run(db, 'db/migrate')
    puts 'Test DB migrations complete.'
  end

  desc 'Create the database (and test database) and run all migrations'
  task :setup do
    require 'uri'
    db_url = ENV['MODBOT_DATABASE_URL'] || 'postgres://localhost/modbot'
    uri = URI.parse(db_url)
    db_name = uri.path[1..-1]
    system("createdb #{db_name}")

    # Also create test database
    test_db_name = db_name.end_with?('_test') ? db_name : "#{db_name}_test"
    system("createdb #{test_db_name}")

    Rake::Task['db:migrate'].invoke
    ENV['MODBOT_DATABASE_URL'] = "postgres://localhost/#{test_db_name}"
    Rake::Task['db:migrate'].reenable
    Rake::Task['db:migrate'].invoke
    ENV['MODBOT_DATABASE_URL'] = db_url
    puts 'Database setup complete.'
  end

  namespace :migrate do
    desc 'Revert (migrate down) one migration'
    task :down do
      Sequel.extension :migration
      Sequel::Migrator.run(ModBot::DB.db, 'db/migrate',
                           target: (Sequel::Migrator.current(ModBot::DB.db, 'db/migrate') - 1))
      puts 'Reverted one migration.'
    end
  end

  desc 'Drop, create, and migrate the database (reset)'
  task :reset do
    require 'uri'
    db_url = ENV['MODBOT_DATABASE_URL'] || 'postgres://localhost/modbot'
    uri = URI.parse(db_url)
    db_name = uri.path[1..-1]
    system("dropdb --if-exists #{db_name}")
    puts "Database dropped: #{db_name}"
    # Also drop test database
    test_db_name = db_name.end_with?('_test') ? db_name : "#{db_name}_test"
    system("dropdb --if-exists #{test_db_name}")
    puts "Test database dropped: #{test_db_name}"
    Rake::Task['db:setup'].invoke
    puts 'Database reset complete.'
  end
end
