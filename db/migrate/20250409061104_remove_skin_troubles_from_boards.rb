class RemoveSkinTroublesFromBoards < ActiveRecord::Migration[7.2]
  def up
    remove_column :boards, :skin_troubles, :string
  end

  def down
    add_column :boards, :skin_troubles, :string
  end
end
