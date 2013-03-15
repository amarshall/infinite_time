class InfiniteTime
  module TimeExtension
    def infinite?
      is_a? InfiniteTime
    end

    def <=> other
      if other.infinite?
        (other.positive?) ? -1 : 1
      else
        super
      end
    end
  end
end
