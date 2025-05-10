require 'rails_helper'

RSpec.describe "Oauths", type: :request do
  describe "GET /oauth/:provider" do
    it "Googleでの認証を開始できること" do
      # モックの場合は先に期待を設定
      expect_any_instance_of(OauthsController).to receive(:login_at).with('google')
      get "/oauth/google"
    end
  end

  describe "GET /oauth/callback" do
    context "既存ユーザーの場合" do
      let(:user) { create(:user) }
      let(:provider) { "google" }

      before do
        # controllerではなく、OauthsControllerのインスタンスに対してモックを設定
        allow_any_instance_of(OauthsController).to receive(:login_from).with(provider).and_return(user)
      end

      it "ログインして root_path にリダイレクトすること" do
        get "/oauth/callback", params: { provider: provider }
        expect(response).to redirect_to(boards_path)
        expect(flash[:notice]).to eq "#{provider.titleize}アカウントでログインしました"
      end
    end

    context "新規ユーザーの場合" do
      let(:user) { create(:user) }
      let(:provider) { "google" }

      before do
        allow_any_instance_of(OauthsController).to receive(:login_from).with(provider).and_return(nil)
        allow_any_instance_of(OauthsController).to receive(:create_from).with(provider).and_return(user)
        allow_any_instance_of(OauthsController).to receive(:auto_login).with(user)
      end

      it "新規ユーザーを作成してログインすること" do
        get "/oauth/callback", params: { provider: provider }
        expect(response).to redirect_to(boards_path)
        expect(flash[:notice]).to eq "#{provider.titleize}アカウントでログインしました"
      end
    end

    context "エラーが発生した場合" do
      let(:provider) { "google" }

      before do
        allow_any_instance_of(OauthsController).to receive(:login_from).with(provider).and_return(nil)
        allow_any_instance_of(OauthsController).to receive(:create_from).with(provider).and_raise("Error")
      end

      it "エラーメッセージとともにroot_pathにリダイレクトすること" do
        get "/oauth/callback", params: { provider: provider }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq "#{provider.titleize}アカウントでのログインに失敗しました"
      end
    end
  end
end
