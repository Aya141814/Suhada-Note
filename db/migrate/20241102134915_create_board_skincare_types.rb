class CreateBoardSkincareTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :board_skincare_types do |t|
      t.references :board, null: false, foreign_key: true
      t.references :skincare_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
