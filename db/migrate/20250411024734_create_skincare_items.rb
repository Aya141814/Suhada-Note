class CreateSkincareItems < ActiveRecord::Migration[7.2]
  def change
    create_table :skincare_items do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :skincare_items, :name, unique: true
  end
end
