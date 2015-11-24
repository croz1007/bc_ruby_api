require_relative 'payment_method'
require_relative 'address'

module Twocheckout

  class Customer

    attr_reader  :shipping_address, :email, :currency, :lang, :payment_methods, :id, :phone

    def initialize(hash)
      @id = hash['id']
      @email = hash['email']
      @phone = hash['phone']
      @currency = hash['currency']
      @lang = hash['lang']
      @payment_methods = hash['payment_methods'].map{|payment_method_data| PaymentMethod.new(payment_method_data)}
      @shipping_address = hash['shipping_address'] #.map{|shipping_address_data| Address.new(shipping_address_data)}
    end

    def self.find(customer_id)
      response = Twocheckout::Requestor.request(:get, "customers/#{customer_id}", nil)
      Customer.new(response['customer'])
    end

    def self.create(args)
      response = Twocheckout::Requestor.request(:post, 'customers', {customer: args})
      Customer.new(response['customer'])
    end

    def self.list(args)
      response = Twocheckout::Requestor.request(:get, 'customers', args)
      CustomerList.new(response)
    end

    def self.update(customer_id, args)
      response = Twocheckout::Requestor.request(:put, "customers/#{customer_id}", {customer: args} )
      Customer.new(response['customer'])
    end

    def self.delete(customer_id)
      response = Twocheckout::Requestor.request(:delete, "customers/#{customer_id}", nil)
      DeleteCustomer.new(response)
    end

  end

  class CustomerList

    attr_reader :customers, :pagination

    def initialize(hash)
      @customers = hash['customers']
      @pagination = hash['pagination']
    end

  end

  class DeleteCustomer

    attr_reader :code, :message

    def initialize(hash)
      @code = hash['code']
      @message = hash['message']
    end

  end

end
