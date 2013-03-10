require 'infinite_time'
require 'infinite_time/time_extension'

class Time
  Infinity = InfiniteTime

  if RUBY_VERSION.to_f >= 2.0
    prepend InfiniteTime::TimeExtension
  else
    include InfiniteTime::TimeExtension
    alias_method :_spaceship, :<=>
    def <=> other; super; end
  end
end
