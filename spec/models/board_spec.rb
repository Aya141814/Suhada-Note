require 'rails_helper'

RSpec.describe Board, type: :model do
  describe "バリデーションチェック" do
    it "設定したバリデーションが機能しているか" do
      board = create(:board)
      expect(board).to be_valid
    end

    it "bodyがなければ無効" do
      board = build(:board, body: nil)
      expect(board).not_to be_valid
    end

    it "bodyが65535文字以上であれば無効" do
      board = build(:board, body: "a" * 65536)
      expect(board).not_to be_valid
    end
  end

  describe "インスタンスメソッド" do
    it "#start_time" do
      board = create(:board)
      expect(board.start_time).to eq(board.created_at)
    end
  end
end
