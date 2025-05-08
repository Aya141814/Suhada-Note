FactoryBot.define do
  factory :user_trophy do
    user
    trophy
    achieved_at { Time.current }
  end
end
