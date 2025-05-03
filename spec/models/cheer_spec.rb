require 'rails_helper'

RSpec.describe Cheer, type: :model do
  describe "バリデーションチェック" do
    it "設定したバリデーションが機能しているか" do
      cheer = create(:cheer)
      expect(cheer).to be_valid
    end
    it "user_idとboard_idの組み合わせが重複している場合は無効であること" do
      user = create(:user)
      board = create(:board, user: user)
      create(:cheer, user: user, board: board)
      duplicate_cheer = build(:cheer, user: user, board: board)
      expect(duplicate_cheer).to be_invalid
    end
    it "user_idとboard_idの組み合わせが重複していない場合は有効であること" do
      user = create(:user)
      board = create(:board, user: user)
      cheer= create(:cheer, user: user, board: board)
      expect(cheer).to be_valid
    end

  end
  
  
end
