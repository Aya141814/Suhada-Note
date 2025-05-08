FactoryBot.define do
  factory :comment do
    user
    board
    body { Faker::Lorem.paragraph }
  end
end
