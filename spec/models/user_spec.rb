require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "設定したバリデーションが機能しているか" do
      user = User.new(name: "test", email: "test@example.com", password: "password")
      expect(user).to be_valid
    end
  end
end
