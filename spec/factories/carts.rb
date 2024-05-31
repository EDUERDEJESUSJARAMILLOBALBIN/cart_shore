FactoryBot.define do
  factory :cart do
    id { BSON::ObjectId.new.to_s }
    updated_at { Time.now }
    created_at { Time.now }
  end
end
