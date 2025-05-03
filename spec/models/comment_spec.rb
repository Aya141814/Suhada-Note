require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "バリデーション" do
    it "bodyがなければ無効" do
      comment = build(:comment, body: nil)
      expect(comment).not_to be_valid
    end
    it "bodyが65535文字以上であれば無効" do
      comment = build(:comment, body: "a" * 65536)
      expect(comment).not_to be_valid
    end
    it "バリデーションが機能しているか" do
      comment = create(:comment)
      expect(comment).to be_valid
    end
  end
  
end
