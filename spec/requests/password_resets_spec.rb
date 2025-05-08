require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  let(:user) { create(:user) }
  describe "GET /new" do
    it "パスワードリセット画面を表示できること" do
      get new_password_reset_path
      expect(response).to have_http_status(200)
    end
  end
  describe "POST /create" do
    context "有効なメールアドレスの場合" do
      it "パスワードリセットのリクエストを送信できること" do
        post password_resets_path, params: { email: user.email }
        expect(response).to redirect_to(login_path)
        expect(flash[:success]).to eq "パスワードリセットのためのメールを送信しました"
      end
    end
    context "無効なメールアドレスの場合" do
      it "エラーメッセージは表示されないこと（セキュリティのため）" do
        post password_resets_path, params: { email: "invalid_email" }
        expect(response).to redirect_to(login_path)
        expect(flash[:success]).to eq "パスワードリセットのためのメールを送信しました"
      end
    end
  end
  describe "GET /password_resets/:id/edit" do
    let(:token) do
      user.deliver_reset_password_instructions! # 戻り値はトークンではなくメールオブジェクト
      user.reload.reset_password_token
    end

    context "有効なトークンの場合" do
      it "編集ページが正しく表示されること" do
        get edit_password_reset_path(token)
        expect(response).to have_http_status(200)
      end
    end
    context "無効なトークンの場合" do
      it "ログイン画面にリダイレクトされること" do
        get edit_password_reset_path("invalid_token")
        expect(response).to redirect_to(login_path)
      end
    end
  end
  describe "PATCH /password_resets/:id" do
    let(:user) { create(:user, reset_password_token: SecureRandom.urlsafe_base64, reset_password_token_expires_at: 1.hour.from_now) }
    let(:token) { user.reset_password_token }

    it "有効なトークンと正しいパスワードの場合 パスワードが変更できること" do
      patch password_reset_path(token), params: {
        user: { password: "password2", password_confirmation: "password2" }
      }
      follow_redirect!
      expect(response.body).to include("パスワードを変更できました")
    end

    context "パスワードと確認用パスワードが一致しない場合" do
      it "パスワードの変更に失敗すること" do
        patch password_reset_path(token), params: {
          user: { password: "password", password_confirmation: "XXXpassword" }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("パスワード変更出来ませんでした")
      end
    end
  end
end
