require_relative 'spec_helper'

describe 'Subscription' do

  include ExampleHelper
  let(:sale) {BCAPIRuby::Sale.create(exampleRecurringSale)}

  describe 'Stop' do

    it 'should stop a subscription' do
      subscription = BCAPIRuby::Subscription.stop(sale.invoices[0].subscriptions[0].id)
      expect(subscription.active).to be false
    end

  end

  describe 'Find' do

    it 'should find a subscription by subscription id' do
      subscription = BCAPIRuby::Subscription.find(sale.invoices[0].subscriptions[0].id)
      expect(subscription).to_not be_nil
      expect(subscription.recurrence).to_not be_nil
      expect(subscription.active).to be true
      expect(subscription.id).to eq(sale.invoices[0].subscriptions[0].id)
    end

  end


end
