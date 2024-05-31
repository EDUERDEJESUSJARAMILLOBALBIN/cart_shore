require 'rails_helper'

RSpec.describe Orderable, type: :model do
  let(:orderable) { create(:orderable) }

  describe 'fields' do
    it { should have_field(:quantity).of_type(Integer) }
    it { should have_field(:total_price).of_type(Integer) }
    it { should have_field(:order_created).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { should have_field(:code_order).of_type(String).with_default_value_of('0000') }
    it { should have_field(:session_id).of_type(String) }
  end

  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:cart) }
  end

  describe 'indexes' do
    it { should have_index_for(cart_id: 1, product_id: 1).with_options(unique: true) }
  end

  describe '#total' do
    it 'calculates the total price of the orderable' do
      product = create(:product, price: 10)
      orderable = create(:orderable, product: product, quantity: 2)

      expect(orderable.total).to eq(20)
    end
  end
end
