require 'rails_helper'

RSpec.describe SkincareItem, type: :model do
  describe 'バリデーション' do
    it 'nameがあれば有効' do
      skincare_item = build(:skincare_item)
      expect(skincare_item).to be_valid
    end

    it 'nameがなければ無効' do
      skincare_item = build(:skincare_item, name: nil)
      expect(skincare_item).not_to be_valid
    end

    it '同じ名前のスキンケアアイテムは作れない' do
      create(:skincare_item, name: 'テストアイテム')
      duplicate_item = build(:skincare_item, name: 'テストアイテム')
      expect(duplicate_item).not_to be_valid
    end
  end
end
