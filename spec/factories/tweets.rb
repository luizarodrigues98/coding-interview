FactoryBot.define do
  factory :tweet do
    body { Faker::Lorem.sentence }
  end
end
