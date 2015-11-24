require_relative 'spec_helper'

describe 'Customer' do

  include ExampleHelper
  let(:customer) {BCAPIRuby::Customer.create(exampleCustomer)}

  describe 'Create' do
    it 'should create a new customer' do
      expect(customer).to be_kind_of(BCAPIRuby::Customer)
      expect(customer).to_not be_nil
    end
  end

  describe 'Find' do
    it 'should find a customer by customer id' do
      found_customer = BCAPIRuby::Customer.find(customer.id)
      expect(found_customer.id).to eq(customer.id)
    end
  end

  describe 'Update' do
    it 'should update a customer' do
      updated_customer = BCAPIRuby::Customer.update(customer.id, {email: 'test@email.com'})
      expect(updated_customer.email).to eq('test@2co.com')
    end
  end

  describe 'Delete' do
    it 'should delete a customer' do
      expect(customer.id).to_not be_nil

      deleted_customer = BCAPIRuby::Customer.delete(customer.id)
      expect(deleted_customer.message).to eq("Customer #{customer.id} removed successfully.")
    end
  end

  describe 'List', :skip_before do
    it 'should return a list of customers' do
      customer_list = BCAPIRuby::Customer.list(examplePagination)
      expect(customer_list.customers.size).to be_between(1,examplePagination[:page_size])
    end
  end

end
