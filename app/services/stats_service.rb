class StatsService
  include RedisConn

  HIT_PREFIX = "HIT_"
  TOTAL_PREFIX = "TOTAL_"

  class << self
    def stats_report(code)
      {
        "#{code}": stat_by_prefix("#{TOTAL_PREFIX}#{code}")
      }
    end

    def save_hit(code, user_data)
      # update_counter("#{TOTAL_PREFIX}#{code}")
    end

    def update_counter(counter)
      current = RedisConn.current.get(counter) || 0
      RedisConn.current.set(counter, current.to_i + 1)
    end

    def stat_by_prefix(prefix)
      RedisConn.current.get(prefix).to_i
    end
  end
end
