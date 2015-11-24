module Twocheckout

  class Pagination

    attr_reader :self, :prev, :next, :last

    def initialize(hash)
      @self = hash['self']
      @prev = hash['prev']
      @next = hash['next']
      @last = hash['last']
    end

  end

end