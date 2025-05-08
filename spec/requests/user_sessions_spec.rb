require 'rails_helper'

RSpec.describe "UserSessions", type: :request do
  let(:user) { create(:user) }
  describe "GET /user_sessions" do
    it "ログイン画面を表示できること" do
      get login_path
      expect(response).to have_http_status(200)
    end
  end
  describe "POST /user_sessions" do
    it "ログインできること" do
      post login_path, params: { email: user.email, password: "password" }
      expect(response).to have_http_status(302)
    end
  end
  describe "DELETE /user_sessions" do
    it "ログアウトできること" do
      login_user(user)
      delete logout_path
      expect(response).to have_http_status(303)
      expect(response).to redirect_to(root_path)
    end
  end
end
