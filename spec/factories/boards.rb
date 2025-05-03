FactoryBot.define do
  factory :board do
    body { Faker::Lorem.paragraph }
    user
  end
end
