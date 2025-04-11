class DropSkinCareCategory < ActiveRecord::Migration[7.2]
  def change
    drop_table :skin_care_categories do |t|
      t.string :name, null: false
      t.timestamps
      t.index :name, unique: true
    end
  end
end
