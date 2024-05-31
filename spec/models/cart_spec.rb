require 'rails_helper'

RSpec.describe Cart, type: :model do
  # Factory
  let(:cart) { create(:cart) }

  describe '#total' do
    it 'calculates the total price of all orderables' do
      product1 = create(:product, price: 10)
      product2 = create(:product, price: 20)
      create(:orderable, cart: cart, product: product1)
      create(:orderable, cart: cart, product: product2)

      expect(cart.total).to eq(30)
    end
  end

  describe '#products' do
    it 'returns all products in the cart' do
      product1 = create(:product)
      product2 = create(:product)
      orderable1 = create(:orderable, cart: cart, product: product1)
      orderable2 = create(:orderable, cart: cart, product: product2)

      expect(cart.products).to contain_exactly(product1, product2)
    end
  end

  describe 'validations' do
    it 'validates the presence of orderables' do
      expect(cart).to have_many(:orderables)
    end
  end
end
