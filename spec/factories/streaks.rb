FactoryBot.define do
  factory :streak do
    user
    current_streak { 1 }
    start_date { Date.current }
  end
end
