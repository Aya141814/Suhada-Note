class CreateTrophies < ActiveRecord::Migration[7.2]
  def change
    create_table :trophies do |t|
      t.string :name, null: false           # トロフィー名
      t.text :description                   # トロフィーの説明
      t.string :trophy_type, null: false    # トロフィータイプ（例：streak、post_count など）
      t.integer :requirement, null: false   # 獲得条件（例：7日、30日など）
      t.string :icon                        # アイコンのパス

      t.timestamps
    end
  end
end
