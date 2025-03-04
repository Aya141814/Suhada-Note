class AddCategoryNameToStreaks < ActiveRecord::Migration[7.2]
  def change
    add_column :streaks, :category_name, :string,  null: false, default: "スキンケア"
    add_index :streaks, [ :user_id, :category_name ], unique: true
  end
end
