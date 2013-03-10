require 'infinite_time/version'
require 'infinite_time/core_ext'

class InfiniteTime < Time
  def initialize sign = :+
    sign = sign.to_sym
    raise InvalidSign unless [:+, :-].include? sign
    @sign = sign
  end

  def positive?
    @sign == :+
  end

  def negative?
    !positive?
  end

  def <=> other
    case other
    when InfiniteTime
      if positive? && other.negative?
        1
      elsif negative? && other.positive?
        -1
      else
        0
      end
    when Time then (positive?) ? 1 : -1
    else raise ArgumentError, "comparison of InfiniteTime with #{other.inspect} failed"
    end
  end

  def + _; self; end
  def - _; self; end

  class InvalidSign < StandardError; end
end
