require_relative 'address'

module Twocheckout

  class SalePaymentMethod

    def initialize(hash)
      @method = hash['method']
      @first_six = hash['first_six']
      @last_two = hash['last_two']
      @exp_month = hash['exp_month']
      @exp_year = hash['exp_year']
      @cvv_match = hash['cvv_match']
      @avs_match = hash['avs_match']
      @billing_address = Address.new(hash['billing_address'])
    end

  end

end