namespace :db do
  namespace :seed do
    desc "共通のシードデータを読み込む（本番環境でも使用）"
    task common: :environment do
      puts "共通のシードデータを読み込んでいます..."

      # スキンケアカテゴリなどの共通データ
      skincare_items = [
        "化粧水", "乳液", "クリーム", "美容液", "オイル", "日焼け止め",
        "クレンジング", "洗顔料", "パック/マスク"
      ]

      skincare_items.each do |name|
        skincare_item = SkincareItem.find_or_create_by!(name: name)
        puts "スキンケアアイテム作成: #{skincare_item.name}"
      end

      skin_troubles = [
        "乾燥", "ニキビ", "シミ", "くすみ", "赤み", "毛穴の開き", "敏感肌", "脂性肌"
      ]

      skin_troubles.each do |name|
        skin_trouble = SkinTrouble.find_or_create_by!(name: name)
        puts "肌トラブル作成: #{skin_trouble.name}"
      end

      trophies = [
        { name: "初めての投稿", description: "初めての投稿をした時に獲得できるトロフィー", trophy_type: "streak", requirement: 1, icon: "first_trophy.png" },
        { name: "一週間継続", description: "一週間継続した時に獲得できるトロフィー", trophy_type: "streak", requirement: 7, icon: "1week_trophy.png" },
        { name: "二週間継続", description: "二週間継続した時に獲得できるトロフィー", trophy_type: "streak", requirement: 14, icon: "2week_trophy.png" },
        { name: "一ヶ月間継続", description: "一ヶ月間継続した時に獲得できるトロフィー", trophy_type: "streak", requirement: 30, icon: "1month_trophy.png" }
      ]

      trophies.each do |trophy|
        Trophy.find_or_create_by!(trophy)
        puts "トロフィー作成: #{trophy[:name]}"
      end

      puts "共通のシードデータの読み込みが完了しました"
    end

    desc "開発環境用のテストデータを読み込む"
    task dev: :environment do
      puts "開発環境用のテストデータを読み込んでいます..."

      # 開発環境のみのテストデータ
      10.times do
        user = User.create!(
          nickname: Faker::Name.name,
          email: Faker::Internet.unique.email,
          password: "password",
          password_confirmation: "password"
        )
        puts "ユーザー作成: #{user.email}"
      end

      user_ids = User.ids

      20.times do |index|
        user = User.find(user_ids.sample)
        board = user.boards.create!(body: "本文#{index}")
        puts "ボード作成: ID #{board.id}, ユーザー: #{user.email}"
      end

      puts "開発環境用のテストデータの読み込みが完了しました"
    end

    desc "全てのシードデータを読み込む（開発環境用）"
    task all: [ :common, :dev ] do
      puts "全てのシードデータの読み込みが完了しました"
    end
  end
end
