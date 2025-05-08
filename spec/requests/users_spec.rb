require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "登録画面が表示できること" do
      get new_user_path
      expect(response).to have_http_status(200)
    end
    context "入力したデータが有効な場合" do
      it "ユーザー登録できること" do
        post users_path, params: { user: { nickname: "test_name", email: "test@example.com", password: "password", password_confirmation: "password" } }
        expect(response).to have_http_status(302)
      end
    end
    context "入力したデータが無効な場合" do
      it "ユーザー登録できないこと" do
        post users_path, params: { user: { nickname: "", email: "test@example.com", password: "password", password_confirmation: "password" } }
        expect(response).to have_http_status(422)
      end
    end
  end
end
