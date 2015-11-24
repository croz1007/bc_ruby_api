require_relative 'spec_helper'

describe 'Payment Method' do

  include ExampleHelper
  let(:customer) {BCAPIRuby::Customer.create(exampleCustomer)}

  describe 'Create' do

    it 'should create a new payment method for a customer' do
      method = BCAPIRuby::PaymentMethod.create(customer.id, examplePaymentMethod)
      expect(method).to_not be_nil
      expect(method.last4).to_not be_nil
      expect(method.exp_month).to_not be_nil
      expect(method.exp_year).to_not be_nil
    end

  end

  describe 'List' do

    it 'should return a list of payment methods' do
      methods = BCAPIRuby::PaymentMethod.list(customer.id, examplePagination)
      expect(methods.payment_methods[0].id).to_not be_nil
      expect(methods.payment_methods.size).to be_between(1,examplePagination[:page_size])
    end

  end

  describe 'Find' do

    it 'should find a payment method by payment method id' do
      found_method = BCAPIRuby::PaymentMethod.find(customer.id, customer.payment_methods[0].id)
      expect(found_method.id).to eq(customer.payment_methods[0].id)
    end

  end

  describe 'Delete' do

    it 'should delete a payment method' do
      method = BCAPIRuby::PaymentMethod.create(customer.id, examplePaymentMethod)
      del_method = BCAPIRuby::PaymentMethod.delete(customer.id, method.id)
      expect(del_method.message).to eq("Payment Method #{method.id} removed successfully.")
    end

  end

  describe 'Default' do

    it 'should change a default payment method' do
      original_method_id = customer.payment_methods[0].id
      method = BCAPIRuby::PaymentMethod.create(customer.id, examplePaymentMethod)

      default_method = BCAPIRuby::PaymentMethod.set_default(customer.id, method.id)
      expect(default_method.default).to eq true

      old_default = BCAPIRuby::PaymentMethod.find(customer.id, original_method_id)
      expect(old_default.default).to eq false
    end

  end

end
