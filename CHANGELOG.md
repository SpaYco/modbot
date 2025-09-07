# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- Initial gem structure
- Event system for Reddit (posts, comments, reports)
- OpenAI and Anthropic (Claude) LLM support
- Platform-agnostic event system (supports future Facebook, Twitter, etc.)
- Database schema now supports platform/resource_type/resource for events and seen_items
- Rakefile: added db:setup, improved db:migrate, and production/deployment notes
- Added PostgreSQL installation/setup instructions to README
- Added support for running migrations and setup in production
- Improved test setup and support mocks
