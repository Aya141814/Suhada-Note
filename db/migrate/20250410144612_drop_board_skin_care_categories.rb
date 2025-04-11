class DropBoardSkinCareCategories < ActiveRecord::Migration[7.2]
  def change
    drop_table :board_skin_care_categories do |t|
      t.references :board, foreign_key: true
      t.references :skin_care_category, foreign_key: true
      t.timestamps
      t.index [:board_id, :skin_care_category_id], unique: true
    end

    
  end
end
