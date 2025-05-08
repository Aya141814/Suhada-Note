require 'rails_helper'

RSpec.describe "Cheers", type: :request do
  describe "POST /cheers" do
    # ログインしている時
    context "when logged in" do
      let(:user) { create(:user) }
      let(:board) { create(:board) }
      
      before do
        login_user(user)
      end

      it "creates a new cheer" do
        post cheers_path, params: { board_id: board.id }, as: :turbo_stream
        expect(response).to have_http_status(200)
      end

      it "increases cheer count" do
        expect {
          post cheers_path, params: { board_id: board.id }, as: :turbo_stream
        }.to change { Cheer.count }.by(1)
      end
    end

    # ログインしてない時
    context "when not logged in" do
      let(:board) { create(:board) }

      it "redirects to login page" do
        post cheers_path, params: { board_id: board.id }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(login_path)
      end
    end
  end
  describe "DELETE /destroy" do
      let(:user) { create(:user) }
      let(:board) { create(:board) }
      let(:cheer) { create(:cheer, board: board, user: user) }

      context "when logged in" do
        before do
          login_user(user)
        end

        it "deletes a cheer" do
          cheer # 事前にcheerを作成
          delete cheer_path(cheer), as: :turbo_stream
          expect(response).to have_http_status(200)
        end

        it "decreases cheer count" do
          cheer # 事前にcheerを作成
          expect {
            delete cheer_path(cheer), as: :turbo_stream
          }.to change { Cheer.count }.by(-1)
        end
      end

      context "when not logged in" do
        it "redirects to login page" do
          delete cheer_path(cheer)
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(login_path)
        end
      end
  end
end