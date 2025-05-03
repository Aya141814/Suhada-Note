require 'rails_helper'

RSpec.describe SkinTrouble, type: :model do
  describe 'バリデーション' do
    it 'nameがあれば有効' do
      skin_trouble = build(:skin_trouble)
      expect(skin_trouble).to be_valid
    end
    it 'nameがなければ無効' do
      skin_trouble = build(:skin_trouble, name: nil)
      expect(skin_trouble).not_to be_valid
    end
    it '同じ名前のスキンケアアイテムは作れない' do
      create(:skin_trouble, name: 'テストアイテム')
      duplicate_item = build(:skin_trouble, name: 'テストアイテム')
      expect(duplicate_item).not_to be_valid
    end
  end
end
