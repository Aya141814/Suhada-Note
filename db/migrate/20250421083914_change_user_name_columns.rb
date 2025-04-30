class ChangeUserNameColumns < ActiveRecord::Migration[7.2]
  def up
    add_column :users, :nickname, :string
    # 既存のデータを移行（first_nameとlast_nameを結合してnicknameに設定）
    User.find_each do |user|
      user.update_column(:nickname, "#{user.first_name} #{user.last_name}".strip)
    end
    
    # ニックネームにNOT NULL制約を追加
    change_column_null :users, :nickname, false
    
    # 不要になったカラムを削除
    remove_column :users, :first_name
    remove_column :users, :last_name
  end

  def down
    # 元に戻す場合のマイグレーション
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    
    # データを戻す処理（簡易的な例）
    User.find_each do |user|
      names = user.nickname.split(' ', 2)
      first_name = names.last || ''
      last_name = names.first || ''
      user.update_columns(first_name: first_name, last_name: last_name)
    end
    
    # NOT NULL制約を追加
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
    
    # nicknameカラムを削除
    remove_column :users, :nickname
  end
end
