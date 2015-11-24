require_relative 'spec_helper'

describe 'Sale' do

  include ExampleHelper
  let(:sale) {BCAPIRuby::Sale.create(exampleSale)}

  describe 'Create' do
    it 'should create a new sale' do
      expect(sale).to be_kind_of(BCAPIRuby::Sale)
      expect(sale).to_not be_nil
      expect(sale.id).to_not be_nil
    end
  end

  describe 'Find' do
    it 'should find a sale by sale_id' do
      found_sale = BCAPIRuby::Sale.find(sale.id)
      expect(found_sale.id).to eq(sale.id)
      expect(found_sale.invoices[0].id).to eq(sale.invoices[0].id)
    end
  end

  describe 'List' do
    it 'should return a list of sales' do
      sale_list = BCAPIRuby::Sale.list(examplePagination)
      expect(sale_list).to_not be_nil
      expect(sale_list.sales.size).to be_between(1,examplePagination[:page_size])
    end
  end


end
