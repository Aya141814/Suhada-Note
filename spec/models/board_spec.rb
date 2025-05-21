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
  describe "メソッドチェック" do
    describe "#trigger_for_streak" do
      let(:user) { create(:user) }

      context "その日に投稿済みの場合" do
        it "falseが返ってくること" do
          previous_board = create(:board, user: user)
          board = create(:board, user: user, created_at: previous_board.created_at + 1.second)
          p user.boards
          day_start = board.created_at.beginning_of_day
          day_end = board.created_at.end_of_day

          is_first_board_on_day = !user.boards
                                  .where(created_at: day_start..day_end)
                                  .where("created_at < ?", board.created_at)
                                  .exists?
          expect(is_first_board_on_day).to be false
        end                       
      end

      context "その日初めての投稿の場合" do
        it "trueが返ってくること" do
          board = create(:board)

          day_start = board.created_at.beginning_of_day
          day_end = board.created_at.end_of_day

          is_first_board_on_day = !user.boards
                                  .where(created_at: day_start..day_end)
                                  .where("created_at < ?", board.created_at)
                                  .exists?
          expect(is_first_board_on_day).to be true
        end
      end
    end
    
    
      
      
  end
end
