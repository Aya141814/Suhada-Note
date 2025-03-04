class CreateStreaks < ActiveRecord::Migration[7.2]
  def change
    create_table :streaks do |t|
      t.references :user, null: false
      t.date :start_date
      t.date :end_date
      t.integer :current_streak, default: 0
      t.timestamps
    end
  end
end
