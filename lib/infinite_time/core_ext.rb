require 'infinite_time'

class Time
  Infinity = InfiniteTime

  def infinite?
    is_a? InfiniteTime
  end

  alias_method :_spaceship, :<=>
  undef <=>
  def <=> other
    if other.infinite?
      (other.positive?) ? -1 : 1
    else
      _spaceship other
    end
  end
end
