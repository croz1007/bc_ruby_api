module Twocheckout

  class Item

    attr_reader :vendor_product_id, :installment, :description, :type, :usd_amount, :tangible, :status, :vendor_amount, :customer_amount, :name, :timestamp, :duration, :startup_fee, :id, :price, :recurrence, :handling

    def initialize(hash)
      @id = hash['id']
      @timestamp = hash['timestamp']
      @type = hash['type']
      @status = hash['status']
      @installment = hash['installment']
      @usd_amount = hash['usd_amount']
      @vendor_amount = hash['vendor_amount']
      @customer_amount = hash['customer_amount']
      @vendor_product_id = hash['vendor_product_id']
      @name = hash['name']
      @description = hash['description']
      @price = hash['price']
      @handling = hash['handling']
      @tangible = hash['tangible']
      @startup_fee = hash['startup_fee']
      @recurrence = hash['recurrence']
      @duration = hash['duration']
    end

  end

end