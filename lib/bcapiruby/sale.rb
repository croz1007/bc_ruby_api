require_relative 'sale_customer'
require_relative 'invoice'
require_relative 'sale_comment'

module Twocheckout

  class Sale

    attr_reader :id, :date_next, :recurring_status, :fraud_status, :merchant_order_id, :customer, :recurring, :customer_currency, :recurring_date_declined, :usd_total, :comments, :vendor_total, :invoices, :usd_refund_total, :vendor_currency, :date_placed, :customer_refund_total, :referrer, :lang, :customer_total, :vendor_refund_total

    def initialize(hash)
      @id = hash['id']
      @usd_total = hash['usd_total']
      @customer_total =  hash['customer_total']
      @vendor_total = hash['vendor_total']
      @merchant_order_id = hash['merchant_order_id']
      @date_placed = hash['date_placed']
      @recurring = hash['recurring']
      @recurring_status = hash['recurring_status']
      @date_next = hash['date_next']
      @recurring_date_declined = hash['recurring_date_declined']
      @customer_currency = hash['customer_currency']
      @vendor_currency = hash['vendor_currency']
      @lang = hash['lang']
      @usd_refund_total = hash['usd_refund_total']
      @customer_refund_total = hash['customer_refund_total']
      @vendor_refund_total = hash['vendor_refund_total']
      @fraud_status = hash['fraud_status']
      @referrer = hash['referrer']
      @customer = SaleCustomer.new(hash['customer'])
      @invoices = hash['invoices'].map{|invoice_data| Invoice.new(invoice_data)}
      @comments = hash['comments'].map{|comment_data| SaleComment.new(comment_data)}
    end

    def self.find(sale_id)
      response = Twocheckout::Requestor.request(:get, "sales/#{sale_id}", nil)
      Sale.new(response['sale'])
    end

    def self.create(args)
      response = Twocheckout::Requestor.request(:post, 'sales', {sale: args})
      Sale.new(response['sale'])
    end

    def self.list(args)
      response = Twocheckout::Requestor.request(:get, 'sales', args)
      SaleList.new(response)
    end

  end

  class SaleList

    attr_reader :sales, :pagination

    def initialize(hash)
      @sales = hash['sales']
      @pagination = hash['pagination']
    end

  end
end

