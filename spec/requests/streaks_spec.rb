require 'rails_helper'

RSpec.describe "Streaks", type: :request do
  let(:user) { create(:user) }
  before do
    login_user(user)
  end
  describe "GET /show" do
    it "ストリーク画面を表示できること" do
      get streak_path
      expect(response).to have_http_status(200)
    end
  end
end
