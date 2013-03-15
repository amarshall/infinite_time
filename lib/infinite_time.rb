require 'infinite_time/version'
require 'infinite_time/core_ext'

class InfiniteTime < Time
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

  def to_i; raise TypeError, 'InfiniteTime has no Integer representation'; end
  def to_r; raise TypeError, 'InfiniteTime has no Rational representation'; end

  def to_s
    "#{@sign}∞"
  end
  alias_method :asctime, :to_s
  alias_method :ctime, :to_s
  alias_method :inspect, :to_s

  def strftime _; to_s; end

  private

  def signed_float
    (positive?) ? Float::INFINITY : -Float::INFINITY
  end

  class InvalidSign < StandardError; end

  module TimeCompatability
    def self.define_method name, arity = 0, &block
      super name do |*args|
        unless arity === args.length
          raise ArgumentError, "wrong number of arguments (#{args.length} for #{arity})"
        end
        instance_exec(*args, &block)
      end
    end

    def self.nil_method name, arity = 0
      define_method(name, arity) { nil }
    end
    def self.nil_methods names
      names.each { |name| nil_method name }
    end

    def self.signed_method name, arity = 0
      define_method(name, arity) { signed_float }
    end
    def self.signed_methods names
      names.each { |name| signed_method name }
    end

    def self.self_method name, arity = 0
      define_method(name, arity) { self }
    end
    def self.self_methods names
      names.each { |name| self_method name }
    end

    signed_methods %i[year month day yday wday hour minute second subsec nsec usec]
    nil_methods %i[monday? tuesday? wednesday? thursday? friday? saturday? sunday?]
    nil_methods %i[dst? isdst gmt? gmt_offset gmtoff utc? utc_offset zone]
    self_method :round, 0..1
    self_method :succ
    alias_method :mday, :day
    alias_method :mon, :month
    alias_method :sec, :second
    alias_method :tv_nsec, :nsec
    alias_method :tv_usec, :usec
  end
  private_constant :TimeCompatability
  include TimeCompatability
end
