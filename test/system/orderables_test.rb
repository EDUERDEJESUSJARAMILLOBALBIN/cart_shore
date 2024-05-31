require 'application_system_test_case'

class OrderablesTest < ApplicationSystemTestCase
  test 'should show orderables index' do
    visit orderables_url
    assert_selector 'h1', text: 'Created Orders'
  end

  test 'should delete a order' do
    product = FactoryBot.create(:product, name: 'Sample Product', price: 9.99)
    visit products_url
    fill_in 'quantity', with: 1, match: :first
    click_on 'Add To Cart', match: :first
    click_on 'Save order'
    assert_selector 'h1', text: 'Created Orders'
    click_on 'Delete Order'
  end
end
