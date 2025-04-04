class AddIsPublicToBoards < ActiveRecord::Migration[7.2]
  def change
    add_column :boards, :is_public, :boolean, default: true, null: false
  end
end
