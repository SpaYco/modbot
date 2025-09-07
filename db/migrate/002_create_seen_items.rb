Sequel.migration do
  change do
    create_table(:seen_items) do
      primary_key :id
      String :platform, null: false # e.g. 'reddit', 'facebook', 'twitter'
      String :resource_type, null: false # e.g. 'subreddit', 'page', etc.
      String :resource, null: false # e.g. subreddit name, page id, etc.
      String :item_id, null: false # post/comment/tweet ID
      String :event_type, null: false
      Time :seen_at
      index %i[platform resource_type resource item_id event_type], unique: true
    end
  end
end
