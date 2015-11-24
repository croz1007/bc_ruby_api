module ExampleHelper

  def exampleCreditCard
    {
        number: '4111111111111111',
        exp_month: 12,
        exp_year: 2019,
        cvv: '123'
    }
  end

  def examplePagination
    {
        page: 1,
        page_size: 25
    }
  end

  def exampleAddress
      {
        name: 'Testing Tester',
        address_1: '123 Test St',
        address_2: 'the attic',
        city: 'Columbus',
        state: 'OH',
        country_code: 'US',
        postal_code: '43123'
    }
  end

  def examplePaymentMethod
    {
        credit_card: exampleCreditCard,
        address: exampleAddress
    }
  end

  def exampleCustomer
    {
        phone: '555-555-5556',
        currency: 'USD',
        lang: 'en',
        email: 'nobody@example.com',
        payment_method: examplePaymentMethod,
        shipping_address: exampleAddress
    }
  end

  def exampleSale
    {
        amount: 1.00,
        merchant_order_id: '123',
        customer: exampleCustomer
    }
  end

  def exampleAuthOnlySale
    {
        amount: 1.00,
        merchant_order_id: '123',
        auth_only: true,
        customer: exampleCustomer
    }
  end

  def exampleRefund
    {
        amount: 1.00,
        currency_type: 'vendor',
        comment: 'Refund Issued'
    }
  end

  def exampleRecurringSale
    {
        amount: 1.00,
        merchant_order_id: '123',
        recurrence: '1 Month',
        customer: exampleCustomer
    }
  end

end
