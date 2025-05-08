require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }
  before do
    login_user(user)
  end
  describe "GET /profiles" do
    it "プロフィール画面を表示できること" do
      get profile_path
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /profiles/edit" do
    it "プロフィール編集画面を表示できること" do
      get edit_profile_path
      expect(response).to have_http_status(200)
    end
  end
  describe "PATCH /profiles" do
    context "パラメータが妥当な場合" do
      it "プロフィールを更新できること" do
        patch profile_path, params: { user: { nickname: "test" } }
        expect(response).to have_http_status(302)
      end
    end
    context "パラメータが不正な場合" do
      it "プロフィールを更新できないこと" do
        patch profile_path, params: { user: { nickname: "" } }
        expect(response).to have_http_status(422)
      end
    end
  end
end
