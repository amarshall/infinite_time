require 'infinite_time'

class InfiniteTime
  module TimeExtension
    def infinite?
      is_a? InfiniteTime
    end

    def <=> other
      if other.infinite?
        (other.positive?) ? -1 : 1
      else
        RUBY_VERSION.to_f >= 2.0 ? super : _spaceship(other)
      end
    end
  end
end
