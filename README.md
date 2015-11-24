# BC_API_Ruby Library

## Requirements
* Ruby v2.1.5+

## Setup

```
bundle install
```

## Using the bindings

Require the dependency.

```ruby
require 'bc_ruby_api'
```

Setup your credentials:

```ruby
BCAPIRuby::Requestor.credentials ({
    sellerId: '208364',
    privateKey: '2222',
    sandbox: false
})
```

### Sales

#### Create

```ruby
credit_card = {
    number: '4111111111111111',
    exp_month: 12,
    exp_year: 2019,
    cvv: '123'
}

address = {
    name: 'Testing Tester',
    address_1: '123 Test St',
    address_2: 'the attic',
    city: 'Columbus',
    state: 'OH',
    country_code: 'US',
    postal_code: '43123'
}

payment_method = {
    credit_card: credit_card,
    address: address
}

customer = {
    phone: '555-555-5556',
    currency: 'USD',
    lang: 'en',
    email: 'nobody@example.com',
    payment_method: payment_method
}

test_sale = {
    amount: 1.00,
    merchant_order_id: '123',
    customer: customer
}

sale = BCAPIRuby::Sale.create(test_sale)
puts sale.id              #sale_id
puts sale.invoices[0].id  #invoice_id
```

#### Find

```ruby
sale = BCAPIRuby::Sale.find(SALE_ID)
puts sale.id              #sale_id
puts sale.invoices[0].id  #invoice_id
```

#### List

```ruby
pagination = {
    page: 1,
    page_size: 25
}
sale_list = BCAPIRuby::Sale.list(pagination)
puts sale_list.sales[0].id        #sale_id
puts sale_list.pagenation.next    #next page
```


### Invoices

#### Find

```ruby
invoice = BCAPIRuby::Invoice.find(INVOICE_ID)
puts invoice.id   #invoiceID
```

#### List

```ruby
pagination = {
    page: 1,
    page_size: 25
}
invoice_list = BCAPIRuby::Sale.list(pagination)
puts invoice_list.invoices[0]        #first invoice
puts invoice_list.pagenation.next    #next page
```

#### Capture

```ruby
invoice = BCAPIRuby::Invoice.capture(INVOICE_ID)
puts invoice.id             #invoiceID
puts invoice.needs_captured #false
```

#### Refund

```ruby
params = {
    amount: 1.00,
    currency_type: 'vendor',
    comment: 'Refund Issued'
}

invoice = BCAPIRuby::Invoice.refund(SALE_ID, params)
puts invoice.id               #invoiceID
puts invoice.refunds[0].id    #refundId
```


### Customers

#### Create

```ruby
credit_card = {
    number: '4111111111111111',
    exp_month: 12,
    exp_year: 2019,
    cvv: '123'
}

address = {
    name: 'Testing Tester',
    address_1: '123 Test St',
    address_2: 'the attic',
    city: 'Columbus',
    state: 'OH',
    country_code: 'US',
    postal_code: '43123'
}

payment_method = {
    credit_card: credit_card,
    address: address
}

test_customer = {
    phone: '555-555-5556',
    currency: 'USD',
    lang: 'en',
    email: 'nobody@example.com',
    payment_method: payment_method
}
customer = BCAPIRuby::Customer.create(test_customer)
puts customer.id                      #customerID
puts customer.payment_methods[0].id   #paymentMethodId
```

#### Find

```ruby
customer = BCAPIRuby::Customer.find(CUSTOMER_ID)
puts customer.id                      #customerID
puts customer.payment_methods[0].id   #paymentMethodId
```

#### List

```ruby
pagination = {
    page: 1,
    page_size: 25
}
customer_list = BCAPIRuby::Sale.list(pagination)
puts customer_list.customers[0].id    #first customer id
puts customer_list.pagenation.next    #next page
```

#### Update

```ruby
customer = BCAPIRuby::Customer.update(CUSTOMER_ID, {email: 'test@email.com'})
puts customer.id    #customerId
puts customer.email #Updated email
```

#### Delete

```ruby
deleted = BCAPIRuby::Customer.delete(CUSTOMER_ID)
puts customer.code  #OK
```


### Payment Methods

#### Create

```ruby
credit_card = {
    number: '4111111111111111',
    exp_month: 12,
    exp_year: 2019,
    cvv: '123'
}

address = {
    name: 'Testing Tester',
    address_1: '123 Test St',
    address_2: 'the attic',
    city: 'Columbus',
    state: 'OH',
    country_code: 'US',
    postal_code: '43123'
}

test_payment_method = {
    credit_card: credit_card,
    address: address
}

payment_method = BCAPIRuby::PaymentMethod.create(CUSTOMER_ID, test_payment_method)
puts payment_method.id     #paymentMethodID
puts payment_method.brand  #VS
```

#### Find

```ruby
payment_method = BCAPIRuby::PaymentMethod.find(CUSTOMER_ID, PAYMENT_METHOD_ID)
puts payment_method.id     #paymentMethodID
puts payment_method.brand  #VS
```

#### List

```ruby
pagination = {
    page: 1,
    page_size: 25
}
payment_method_list = BCAPIRuby::Sale.list(pagination)
puts payment_method_list.payment_methods[0].id    #first customer id
```

#### Set Default

```ruby
payment_method = BCAPIRuby::PaymentMethod.set_default(CUSTOMER_ID, PAYMENT_METHOD_ID)
puts payment_method.isDefault  #true
```

#### Delete

```ruby
deleted_payment_method = BCAPIRuby::PaymentMethod.delete($customer.id, method.id)
puts deleted_payment_method.code  #OK
```


### Subscriptions

_Subscriptions (recurring items) can be created when creating a sale by passing a recurrence and optionally a duration._

#### Stop

```ruby
recurring_sale = {
    amount: 1.00,
    merchant_order_id: '123',
    recurrence: '1 Month',
    customer: CUSTOMER_ID
}

sale = BCAPIRuby::Sale.create(recurring_sale)
subscription = BCAPIRuby::Subscription.stop(sale.invoices[0].subscriptions[0].id)
puts subscription.id      #subscriptionID
puts subscription.active  #false
```

#### Find

```ruby
recurring_sale = {
    amount: 1.00,
    merchant_order_id: '123',
    recurrence: '1 Month',
    customer: CUSTOMER_ID
}

sale = BCAPIRuby::Sale.create(recurring_sale)
subscription = BCAPIRuby::Subscription.find(sale.invoices[0].subscriptions[0].id)
puts subscription.id      #subscriptionID
puts subscription.active  #true
```


##  Handling Exceptions
Errors will be thrown if the request is not successful. You should always check the error object in your callback so that you can cleanly handle exceptions.

```ruby
begin
  sale = BCAPIRuby::Sale.create(test_sale)
  puts sale.id
rescue => e
  puts e.message
end
```


## Running the tests

```
rspec
```
