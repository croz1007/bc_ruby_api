require_relative 'address'
require_relative 'pagination'

module Twocheckout

  class PaymentMethod

    attr_reader :address, :default, :last4, :exp_month, :brand, :exp_year, :id

    def initialize(hash)
       @id = hash['id']
       @last4 = hash['last4']
       @brand = hash['brand']
       @exp_month = hash['exp_month']
       @exp_year = hash['exp_year']
       @default = hash['default']
       @address = Address.new(hash['billing_address'])
    end

    def self.create(customer_id, args)
      response = Twocheckout::Requestor.request(:post, "customers/#{customer_id}/payment_methods", {payment_method: args})
      PaymentMethod.new(response['payment_method'])
    end

    def self.find(customer_id, payment_method_id)
      response = Twocheckout::Requestor.request(:get, "customers/#{customer_id}/payment_methods/#{payment_method_id}", nil)
      PaymentMethod.new(response['payment_method'])
    end

    def self.list(customer_id, args)
      response = Twocheckout::Requestor.request(:get, "customers/#{customer_id}/payment_methods", args)
      PaymentMethodList.new(response)
    end

    def self.set_default(customer_id, payment_method_id)
      response = Twocheckout::Requestor.request(:post, "customers/#{customer_id}/payment_methods/#{payment_method_id}/default", nil)
      PaymentMethod.new(response['payment_method'])
    end

    def self.delete(customer_id, payment_method_id)
      response = Twocheckout::Requestor.request(:delete, "customers/#{customer_id}/payment_methods/#{payment_method_id}", nil)
      DeletedPaymentMethod.new(response)
    end

  end

  class PaymentMethodList

    attr_reader :payment_methods, :pagination

    def initialize(hash)
      @payment_methods= hash['payment_methods'].map{|payment_method_data| PaymentMethod.new(payment_method_data)}
      @pagination = hash['pagination']
    end

  end

  class DeletedPaymentMethod

    attr_reader :code, :message

    def initialize(hash)
      @message = hash['message']
      @code = hash['code']
    end

  end

end

