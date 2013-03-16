class InfiniteTime < Time
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
end
