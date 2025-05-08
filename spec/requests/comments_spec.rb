require 'rails_helper'

RSpec.describe "Comments", type: :request do
  context "when logged in" do
    let(:user) { create(:user) }
    let(:board) { create(:board) }
    let(:comment) { create(:comment, user: user, board: board) }
    before do
      login_user(user)
    end
    describe "POST /comments" do
      it "creates a comment" do
        post board_comments_path(board), params: { comment: { body: "test" } }, as: :turbo_stream
        expect(response).to have_http_status(200)
      end
    end
    describe "DELETE /comments" do
      it "deletes a comment" do
        delete comment_path(comment), as: :turbo_stream
        expect(response).to have_http_status(200)
      end
    end
  end
end
