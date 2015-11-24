module Twocheckout

  class TwoCheckoutError < StandardError

    attr_reader :message, :code

    def initialize(message, code = nil)
      @message = message
      @code = code
    end

  end

end

