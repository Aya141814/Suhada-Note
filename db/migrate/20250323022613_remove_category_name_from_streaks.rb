class RemoveCategoryNameFromStreaks < ActiveRecord::Migration[7.2]
  def change
    # インデックスを先に削除
    remove_index :streaks, [:user_id, :category_name], if_exists: true
    # カラムを削除
    remove_column :streaks, :category_name
  end
end
