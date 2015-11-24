require_relative 'address'
require_relative 'sale_payment_method'

module Twocheckout

  class SaleCustomer

    attr_reader :shipping_address, :email, :payment_method, :phone

    def initialize(hash)
      @phone = hash['phone']
      @email = hash['email']
      @shipping_address = Address.new(hash['shipping_address'])
      @payment_method = SalePaymentMethod.new(hash['payment_method'])
    end

  end

end