require 'infinite_time'
require 'infinite_time/time_extension'

class Time
  Infinity = InfiniteTime
  prepend InfiniteTime::TimeExtension
end
