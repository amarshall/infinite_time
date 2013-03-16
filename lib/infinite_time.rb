require 'infinite_time/version'
require 'infinite_time/core_ext'
require 'infinite_time/time_compatability'

class InfiniteTime < Time
  include TimeCompatability

  class << self
    undef at
    undef gm
    undef local
    undef mktime
    undef now
    undef utc
  end

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

  def hash
    self.class.hash ^ @sign.hash
  end

  def to_f
    (positive?) ? Float::INFINITY : -Float::INFINITY
  end

  def to_i; raise TypeError, 'InfiniteTime has no Integer representation'; end
  def to_r; raise TypeError, 'InfiniteTime has no Rational representation'; end

  def to_s
    "#{@sign}∞"
  end
  alias_method :asctime, :to_s
  alias_method :ctime, :to_s
  alias_method :inspect, :to_s

  def strftime _; to_s; end

  class InvalidSign < StandardError; end
end
