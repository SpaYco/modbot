
# ModBot

AI-powered Reddit moderation bot for Ruby. Register moderation events in code—no database required! Works in plain Ruby or Rails.

Supports event-based moderation for posts, comments, and reports using LLMs (OpenAI, Anthropic).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'modbot', github: 'SpaYco/modbot'
```

And then execute:

    $ bundle install


## Setup

1. **Install dependencies:**

```sh
  bundle install
```


## Usage

### Plain Ruby

Create a file (e.g., `my_bot.rb`):

```ruby
require 'modbot'

ModBot.configure do |config|
  config.reddit_client_id = "..."
  config.reddit_secret = "..."
  config.reddit_username = "..."
  config.reddit_password = "..."
  config.openai_api_key = "..." # or config.anthropic_api_key = "..."
  config.model = "gpt-4" # or "claude-3"
end

ModBot::Reddit.on_post(subreddit: "yoursubreddit", prompt: "Is this spam?", interval: "5m") do |post, ai_response|
  # handle post moderation
end

ModBot::Reddit.on_comment(subreddit: "yoursubreddit", prompt: "Is this a helpful comment?", interval: "1h") do |comment, ai_response|
  # handle comment moderation
end

# Start polling (or use your own runner)
# ModBot::Reddit.start_polling(subreddit: "yoursubreddit", interval: 30)
```

### In Rails

Add to your Gemfile:

```ruby
gem 'modbot', github: 'SpaYco/modbot'
```

Then in an initializer (e.g., `config/initializers/modbot.rb`):

```ruby
ModBot.configure do |config|
  config.reddit_client_id = "..."
  config.reddit_secret = "..."
  config.reddit_username = "..."
  config.reddit_password = "..."
  config.openai_api_key = "..."
  config.model = "gpt-4"
end

# Register events in any file loaded by Rails (e.g., in `config/initializers/modbot_events.rb`):
ModBot::Reddit.on_post(subreddit: "yoursubreddit", prompt: "Is this spam?", interval: "5m") do |post, ai_response|
  # handle post moderation
end
```

```ruby
  require 'modbot'

  ModBot.configure do |config|
    config.reddit_client_id = "..."
    config.reddit_secret = "..."
    config.reddit_username = "..."
    config.reddit_password = "..."
    config.openai_api_key = "..." # or config.anthropic_api_key = "..."
    config.model = "gpt-4" # or "claude-3"
  end
```

## Registering Events

Register moderation events for posts, comments, or reports. Each event requires a subreddit, prompt, and interval (e.g., '5m', '1d').

See usage examples above for both plain Ruby and Rails.


## Running the Bot

You can start polling in your script with:

```ruby
ModBot::Reddit.start_polling(subreddit: "yoursubreddit", interval: 30)
```

Or build your own runner/cron logic as needed.

**No database required!** All events are registered in memory when your code is loaded.

## Links

- [GitHub Repository](https://github.com/SpaYco/modbot)

## License

MIT
