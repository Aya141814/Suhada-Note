class CheersController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.cheer(@board)
  end

  def destroy
    @board = current_user.cheers.find(params[:id]).board
    current_user.uncheer(@board)
  end
end
