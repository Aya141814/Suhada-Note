FactoryBot.define do
  factory :trophy do
    name { Faker::Lorem.word }
    trophy_type { "streak" }
    requirement { 1 }
  end
end
