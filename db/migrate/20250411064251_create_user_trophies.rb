class CreateUserTrophies < ActiveRecord::Migration[7.2]
  def change
    create_table :user_trophies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :trophy, null: false, foreign_key: true
      t.datetime :achieved_at, null: false  # 獲得日時

      t.timestamps
    end

    # ユーザーは同じトロフィーを1回だけ獲得できる
    add_index :user_trophies, [ :user_id, :trophy_id ], unique: true
  end
end
