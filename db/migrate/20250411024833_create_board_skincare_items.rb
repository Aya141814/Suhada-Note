class CreateBoardSkincareItems < ActiveRecord::Migration[7.2]
  def change
    create_table :board_skincare_items do |t|
      t.references :board, foreign_key: true
      t.references :skincare_item, foreign_key: true
      t.timestamps
    end
    add_index :board_skincare_items, [ :board_id, :skincare_item_id ], unique: true
  end
end
