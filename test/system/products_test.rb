require 'application_system_test_case'

class ProductsTest < ApplicationSystemTestCase
  test 'should show products index' do
    visit products_url
    assert_selector 'h1', text: 'Products'
  end

  test 'should show a product' do
    product = FactoryBot.create(:product, name: 'Sample Product', price: 9.99)
    visit products_url
    click_link 'Show this product', match: :first
    assert_selector 'a', text: 'Edit this product'
  end

  test 'should create a new product' do
    visit new_product_url
    fill_in 'Name', with: 'New Product'
    fill_in 'Price', with: '19.99'
    click_on 'Create Product'
    assert_text 'Product was successfully created'
  end

  test 'should update a product' do
    product = FactoryBot.create(:product, name: 'Old Product', price: 9.99)
    visit edit_product_url(product)
    fill_in 'Name', with: 'Updated Product'
    fill_in 'Price', with: '14.99'
    click_on 'Update Product'
    assert_text 'Product was successfully updated'
  end

  test 'should delete a product' do
    product = FactoryBot.create(:product, name: 'Product to Delete', price: 9.99)
    visit products_url
    click_link 'Show this product', match: :first
    click_on 'Destroy this product'
    assert_text 'Product was successfully destroyed.'
  end
end
