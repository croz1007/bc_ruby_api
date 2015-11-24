module Twocheckout

  class SaleComment

    attr_reader :timestamp, :comment

    def initialize(hash)
      @timestamp = hash['timestamp']
      @comment = hash['comment']
    end

  end

end