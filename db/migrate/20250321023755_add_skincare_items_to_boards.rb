class AddSkincareItemsToBoards < ActiveRecord::Migration[7.2]
  def change
    add_column :boards, :skincare_items, :string
  end
end
