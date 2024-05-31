FactoryBot.define do
  factory :orderable do
    code_order { "JWO#{Faker::Alphanumeric.alpha(3).upcase}" }
    quantity { 1 }
    order_created { true }
    cart
    product
    updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    session_id { Faker::Alphanumeric.alphanumeric(number: 32) }
  end
end
