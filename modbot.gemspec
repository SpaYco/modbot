# frozen_string_literal: true
require_relative 'lib/mod_bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'modbot'
  spec.version       = ModBot::VERSION
  spec.authors       = ['Aziz']
  spec.email         = ['aziz@mejri.dev']

  spec.summary       = 'AI-powered moderator bot.'
  spec.description   = 'A Ruby gem for building moderator bots. Currently supports Reddit, with other platforms planned. Uses LLMs like OpenAI and Anthropic for moderation of posts, comments, and reports.'
  spec.homepage      = 'https://github.com/SpaYco/modbot'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7'

  spec.add_dependency 'anthropic'
  spec.add_dependency "base64"
  spec.add_dependency 'pg'
  spec.add_dependency 'rake'
  spec.add_dependency 'redd'
  spec.add_dependency 'ruby-openai'
  spec.add_dependency 'sequel'
  spec.add_dependency 'zeitwerk'
end
