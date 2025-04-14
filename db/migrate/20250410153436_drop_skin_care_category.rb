class DropSkinCareCategory < ActiveRecord::Migration[7.2]
  def change
    if table_exists?(:skin_care_categories)
      drop_table :skin_care_categories do |t|
        t.string :name, null: false
        t.timestamps
        t.index :name, unique: true
      end
    end
  end
end
