FactoryBot.define do
  factory :board do
    association :user
    body { Faker::Lorem.paragraph }
    is_public { true }
  end
end
