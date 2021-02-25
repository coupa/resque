module Resque
  # The stat subsystem. Used to keep track of integer counts.
  #
  #   Get a stat:  Stat[name]
  #   Incr a stat: Stat.incr(name)
  #   Decr a stat: Stat.decr(name)
  #   Kill a stat: Stat.clear(name)
  module Stat
    extend self

    # Returns the int value of a stat, given a string stat name.
    def get(redis, stat)
      redis.get("stat:#{stat}").to_i
    end

    # Alias of `get`
    def [](redis, stat)
      get(redis, stat)
    end

    # For a string stat name, increments the stat by one.
    #
    # Can optionally accept a second int parameter. The stat is then
    # incremented by that amount.
    def incr(redis, stat, by = 1)
      redis.incrby("stat:#{stat}", by)
    end

    # For a string stat name, decrements the stat by one.
    #
    # Can optionally accept a second int parameter. The stat is then
    # decremented by that amount.
    def decr(redis, stat, by = 1)
      redis.decrby("stat:#{stat}", by)
    end

    # Removes a stat from Redis, effectively setting it to 0.
    def clear(redis, stat)
      redis.del("stat:#{stat}")
    end
  end
end
