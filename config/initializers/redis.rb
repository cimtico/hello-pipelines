require "redis"

host = ENV.fetch("REDIS_MASTER_BASE_URL", ENV.fetch("REDIS_URL", "redis"))

REDIS_CONNECTION_URL = "redis://#{host}:6379/"
REDIS_INSTANCE = Redis.new(url: REDIS_CONNECTION_URL)
