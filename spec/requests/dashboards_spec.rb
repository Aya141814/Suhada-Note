require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  let(:user) { create(:user) }
  before do
    login_user(user)
  end
  describe "GET /dashboards" do
    it "ダッシュボード（スキンケアログ)を表示できる" do
      get dashboard_path
      expect(response).to have_http_status(200)
    end
  end
end
