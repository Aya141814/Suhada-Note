class AddSkinTroublesToBoards < ActiveRecord::Migration[7.2]
  def change
    add_column :boards, :skin_troubles, :string
  end
end
