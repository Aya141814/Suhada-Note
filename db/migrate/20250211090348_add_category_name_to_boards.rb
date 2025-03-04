class AddCategoryNameToBoards < ActiveRecord::Migration[7.2]
  def change
    add_column :boards, :category_name, :string, null: false, default: "スキンケア"
    add_index :boards, [ :user_id, :category_name ]
  end
end
