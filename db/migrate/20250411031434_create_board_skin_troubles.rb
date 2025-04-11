class CreateBoardSkinTroubles < ActiveRecord::Migration[7.2]
  def change
    create_table :board_skin_troubles do |t|
      t.references :board, null: false, foreign_key: true
      t.references :skin_trouble, null: false, foreign_key: true
      t.timestamps
    end
    add_index :board_skin_troubles, [:board_id, :skin_trouble_id], unique: true
  end
end
