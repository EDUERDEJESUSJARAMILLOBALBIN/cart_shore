require 'application_system_test_case'

class CartsTest < ApplicationSystemTestCase
  test 'Validate card' do
    visit products_url
    assert_selector 'h1', text: 'Cart'
  end

  test 'add product to cart' do
    product = FactoryBot.create(:product, name: 'Sample Product', price: 9.99)
    visit products_url
    fill_in 'quantity', with: 1, match: :first
    click_on 'Add To Cart', match: :first
  end

   test 'save the order of products' do
     product = FactoryBot.create(:product, name: 'Sample Product', price: 9.99)
     visit products_url
     fill_in 'quantity', with: 1, match: :first
     click_on 'Add To Cart', match: :first
     click_on 'Save order'
     assert_selector 'h1', text: 'Created Orders'
   end
end
