# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "標準のseed実行: Rakeタスクを呼び出します..."
# Rakeタスクを実行
if Rails.env.production?
  # 本番環境では共通データのみ
  Rake::Task["db:seed:common"].invoke
else
  # 開発環境ではすべてのデータ
  Rake::Task["db:seed:all"].invoke
end

puts "seed処理が完了しました"
