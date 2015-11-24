require_relative 'spec_helper'

describe 'Invoice' do

  include ExampleHelper
  let(:sale) {BCAPIRuby::Sale.create(exampleSale)}

  describe 'Find' do
    it 'should find an invoice by invoice id' do
      found_invoice = BCAPIRuby::Invoice.find(sale.invoices[0].id)
      expect(found_invoice.id).to eq(sale.invoices[0].id)
    end
  end

  describe 'List' do
    it 'should return a list of invoices' do
      invoices = BCAPIRuby::Invoice.list(examplePagination)
      expect(invoices.invoices.size).to be_between(1,examplePagination[:page_size])
      expect(invoices.invoices[0]['id']).to_not be_nil
    end
  end

  describe 'Capture' do
    let(:auth_sale) {BCAPIRuby::Sale.create(exampleAuthOnlySale)}

    it 'should capture an invoice' do
      found_invoice = BCAPIRuby::Invoice.find(auth_sale.invoices[0].id)
      expect(found_invoice.needs_captured).to eq true

      captured_invoice = BCAPIRuby::Invoice.capture(found_invoice.id)
      expect(captured_invoice.needs_captured).to eq false
    end
  end

  describe 'Refund' do
    it 'should refund an invoice' do
      found_invoice = BCAPIRuby::Invoice.find(sale.invoices[0].id)
      expect(found_invoice.refunds.size).to eq(0)

      refunded_invoice = BCAPIRuby::Invoice.refund(found_invoice.id, exampleRefund)
      expect(refunded_invoice).to_not be_nil
      expect(refunded_invoice.refunds).to_not be_nil
    end
  end

end
