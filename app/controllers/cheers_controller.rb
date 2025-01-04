class CheersController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    current_user.cheer(board)
    redirect_to boards_path, success: t(".success")
  end

  def destroy
    board = current_user.cheers.find(params[:id]).board
    current_user.uncheer(board)
    redirect_to boards_path, success: t(".success"), status: :see_other
  end
end
