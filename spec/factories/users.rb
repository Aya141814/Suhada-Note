FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:first_name) { |n| "名前#{n}" }
    sequence(:last_name) { |n| "苗字#{n}" }
    password { "password" }
    password_confirmation { "password" }

    # アバターを設定する場合（オプション）
    # avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/images/test_avatar.jpg'), 'image/jpeg') }

    trait :with_boards do
      after(:create) do |user|
        create_list(:board, 3, user: user)
      end
    end

    trait :with_comments do
      after(:create) do |user|
        create_list(:comment, 3, user: user)
      end
    end

    # 管理者ユーザーなどの特別なユーザーが必要な場合に追加するトレイト
    # trait :admin do
    #   role { "admin" }
    # end
  end
end
