class RemoveTitleFromBoards < ActiveRecord::Migration[7.2]
  def change
    remove_column :boards, :title, :string
  end
end
