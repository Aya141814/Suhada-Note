require 'rails_helper'

RSpec.describe Trophy, type: :model do
  describe "バリデーションチェック" do
    it "名前が空の場合は無効であること" do
      trophy = build(:trophy, name: nil)
      expect(trophy).to be_invalid
    end
    it "トロフィータイプが空の場合は無効であること" do
      trophy = build(:trophy, trophy_type: nil)
      expect(trophy).to be_invalid
    end
    it "条件が空の場合は無効であること" do
      trophy = build(:trophy, requirement: nil)
      expect(trophy).to be_invalid
    end
    it "条件が0より小さい場合は無効であること" do
      trophy = build(:trophy, requirement: 0)
      expect(trophy).to be_invalid
    end
    it "設定したバリデーションが機能していること" do
      trophy = create(:trophy)
      expect(trophy).to be_valid
    end
  end
  describe "#check_achievement" do
    it "ストリークの場合はtrueを返すこと" do
      user = create(:user)
      create(:streak, user: user, current_streak: 10)
      trophy = create(:trophy, trophy_type: "streak")
      expect(trophy.check_achievement(user)).to be true
    end
    it "ストリーク以外の場合はfalseを返すこと" do
      user = create(:user)
      trophy = create(:trophy, trophy_type: "comment")
      expect(trophy.check_achievement(user)).to be false
    end
  end
end