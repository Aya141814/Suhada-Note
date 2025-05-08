require 'rails_helper'

RSpec.describe "Boards", type: :request do
  let(:user) { create(:user) }
  let(:board) { create(:board) }

  describe "GET /index" do
    it "returns http success" do
      # テスト環境ではすべてを許可する設定になっていることを確認
      get boards_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get board_path(board)
      expect(response).to have_http_status(200)
    end
  end

  context "when logged in" do
    before do
      login_user(user)
    end

    describe "GET /new" do
      it "returns http success" do
        get new_board_path
        expect(response).to have_http_status(200)
      end
    end
  
    describe "POST /create" do
      it "returns http success" do
        post boards_path, params: { board: { body: "test" } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(boards_path)
      end
    end

    describe "GET /edit" do
      it "returns http success" do
        board = create(:board, user: user)
        get edit_board_path(board)
        expect(response).to have_http_status(200)
      end
    end 

    describe "PATCH /update" do
      it "returns http success" do
        board = create(:board, user: user)
        patch board_path(board), params: { board: { body: "test" } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(board_path(board))
      end
    end

    describe "DELETE /destroy" do
      it "returns http success" do
        board = create(:board, user: user)
        delete board_path(board)
        expect(response).to have_http_status(303)
        expect(response).to redirect_to(boards_path)
      end
    end
  end
  context "when not logged in" do
    describe "GET /new" do
      it "redirects to login page" do
        get new_board_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(login_path)
      end
    end
    describe "POST /create" do
      it "redirects to login page" do
        post boards_path, params: { board: { body: "test" } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(login_path)
      end
    end
  end

end
