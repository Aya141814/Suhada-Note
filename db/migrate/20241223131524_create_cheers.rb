class CreateCheers < ActiveRecord::Migration[7.2]
  def change
    create_table :cheers do |t|
      t.references :user, foreign_key: true
      t.references :board, foreign_key: true
      t.timestamps
    end
    add_index :cheers, [ :user_id, :board_id ], unique: true
  end
end
