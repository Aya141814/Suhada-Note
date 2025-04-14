class RemoveSkincareItemsFromBoards < ActiveRecord::Migration[7.2]
  def up
    remove_column :boards, :skincare_items, :string
  end

  def down
    add_column :boards, :skincare_items, :string
  end
end
