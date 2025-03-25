class RemoveCategoryNameFromBoards < ActiveRecord::Migration[7.2]
  def change
    remove_index :boards, [ :user_id, :category_name ], if_exists: true
    remove_column :boards, :category_name
  end
end
