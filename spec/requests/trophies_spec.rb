require 'rails_helper'

RSpec.describe "Trophies", type: :request do
  let(:user) { create(:user) }
  before do
    login_user(user)
  end
  describe "GET /trophies" do
    it "トロフィー一覧が表示できること" do
      get trophies_path
      expect(response).to have_http_status(200)
    end
  end
end
