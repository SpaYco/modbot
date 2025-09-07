# ModBot

AI-powered Reddit moderation bot for Ruby. Supports event-based moderation for posts, comments, and reports using LLMs (OpenAI, Anthropic).

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

2. **Configure your database:**

- Copy `.env.example` to `.env` and set your PostgreSQL URL if needed.
- By default, it uses `postgres://localhost/modbot`.

3. **Run database migrations:**

```sh
  bundle exec rake db:migrate
```

4. **Configure Reddit and LLM credentials:**
   In your Ruby script:

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

```ruby
ModBot::Reddit.on_post(subreddit: "yoursubreddit", prompt: "Is this spam?", interval: "5m") do |post, ai_response|
  # handle post moderation
end

ModBot::Reddit.on_comment(subreddit: "yoursubreddit", prompt: "Is this a helpful comment?", interval: "1h") do |comment, ai_response|
  # handle comment moderation
end
```

## Running the Bot (Cron)

The gem provides a runner script to process events efficiently. Add this to your crontab to run every minute:

```
* * * * * cd /path/to/your/project && bundle exec ruby bin/modbot_cron
```

This script will:

- Check which events are due (based on their interval)
- Group by subreddit and event type to minimize API calls
- Fetch new posts/comments, call the LLM, and trigger your handlers

## Database

- Uses PostgreSQL for event and seen-item persistence.
- Configure via the `MODBOT_DATABASE_URL` environment variable or `.env` file.

## Links

- [GitHub Repository](https://github.com/SpaYco/modbot)

## License

MIT
