Sequel.migration do
  change do
    create_table(:events) do
      primary_key :id
      String :platform, null: false # e.g. 'reddit', 'facebook', 'twitter'
      String :resource_type, null: false # e.g. 'subreddit', 'page', 'hashtag', etc.
      String :resource, null: false # e.g. subreddit name, page id, etc.
      String :event_type, null: false # post, comment, report, tweet, etc.
      String :prompt, null: false
      String :handler_code, text: true # serialized handler (for now, store as string)
      String :interval, null: false # e.g. '5m', '1d'
      Time :last_checked
      Time :created_at
      Time :updated_at
    end
  end
end
