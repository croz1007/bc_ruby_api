require_relative 'item'
require_relative 'subscription'
require_relative 'refund'

module Twocheckout

  class Invoice

    attr_reader :vendor_order_id, :refunds, :customer_currency, :recurring, :date_shipped, :usd_total, :vendor_total, :sale_id, :tco_fees, :status, :needs_captured, :subscriptions, :vendor_currency, :date_placed, :items, :customer_total, :id

    def initialize(hash)
      @id = hash['id']
      @sale_id = hash['sale_id']
      @date_placed = hash['date_placed']
      @date_shipped = hash['date_shipped']
      @customer_total = hash['customer_total']
      @vendor_total = hash['vendor_total']
      @usd_total = hash['usd_total']
      @customer_currency = hash['customer_currency']
      @vendor_currency = hash['vendor_currency']
      @tco_fees = hash['tco_fees']
      @vendor_order_id = hash['vendor_order_id']
      @status = hash['status']
      @recurring = hash['recurring']
      @needs_captured = hash['needs_captured']
      @refunds = hash['refunds'].map{|refund_data| Refund.new(refund_data)}
      @subscriptions = hash['subscriptions'].map{|subscription_data| Subscription.new(subscription_data)}
      @items = hash['items'].map{|item_data| Item.new(item_data)}
    end

    def self.find(invoice_id)
      response = Twocheckout::Requestor.request(:get, "invoices/#{invoice_id}", nil)
      Invoice.new(response['invoice'])
    end

    def self.list(args)
      response = Twocheckout::Requestor.request(:get, 'invoices', args)
      InvoiceList.new(response)
    end

    def self.refund(invoice_id, args)
      response = Twocheckout::Requestor.request(:post, "invoices/#{invoice_id}/refund", {refund: args})
      Invoice.new(response['invoice'])
    end

    def self.capture(invoice_id)
      response = Twocheckout::Requestor.request(:post, "invoices/#{invoice_id}/capture", nil)
      Invoice.new(response['invoice'])
    end

  end

  class InvoiceList

    attr_reader :invoices, :pagination

    def initialize(hash)
      @invoices = hash['invoices']
      @pagination = hash['pagination']
    end

  end
end

