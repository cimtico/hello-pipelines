puts "USING REDIS CONNECTION: #{REDIS_CONNECTION_URL}"

Sidekiq.configure_server do |config|
  config.redis = { url: REDIS_CONNECTION_URL }
end

Sidekiq.configure_client do |config|
  config.redis = { url: REDIS_CONNECTION_URL }
end