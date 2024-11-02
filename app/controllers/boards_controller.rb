class BoardsController < ApplicationController
  def index
    @boards = Board.includes(:user)
  end

  def new
    @board = Board.new
    @skincare_types = SkincareType.all
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: t("defaults.flash_message.created", item: Board.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_created", item: Board.model_name.human)
      @skincare_types = SkincareType.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, skincare_type_ids: [])
  end
end
