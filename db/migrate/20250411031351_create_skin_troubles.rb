class CreateSkinTroubles < ActiveRecord::Migration[7.2]
  def change
    create_table :skin_troubles do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :skin_troubles, :name, unique: true
  end
end
