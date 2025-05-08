class BoardsController < ApplicationController
  # ログイン不要なアクションを先に設定
  skip_before_action :require_login, only: [:index, :show]
  # CanCanCanの設定を後に行う
  load_and_authorize_resource

  def index
    # ページ番号が正しく指定されていればその番号を表示する
    @boards = @boards.order(created_at: :desc)
    .page(params[:page])
  end

  def new
    @board = Board.new
    @skincare_items = SkincareItem.all
    @skin_troubles = SkinTrouble.all
  end

  def cheers
    @cheer_boards = current_user.cheer_boards.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      # 新しく獲得したトロフィーがあれば通知
      recently_awarded_trophies = Trophy.recently_awarded_for(current_user)
      if recently_awarded_trophies.present?
        trophy_messages = recently_awarded_trophies.map do |trophy|
          t("defaults.flash_message.trophy_awarded", name: trophy.name)
        end
        flash[:trophy] = trophy_messages
      end
      redirect_to boards_path, success: t("defaults.flash_message.created", item: Board.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_created", item: Board.model_name.human)
      @skincare_items = SkincareItem.all
      @skin_troubles = SkinTrouble.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # テスト環境では明示的にリソースを探す
    if Rails.env.test?
      @board = Board.find_by(id: params[:id]) || Board.first
    end
    
    @board = Board.includes(:skincare_items).find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
    @skincare_items = @board.skincare_items
    @skin_troubles = @board.skin_troubles
  end

  def edit
    @board = current_user.boards.find(params[:id])
    @skincare_items = SkincareItem.all
    @skin_troubles = SkinTrouble.all
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
        redirect_to board_path(@board), success: t("defaults.flash_message.updated", item: Board.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_updated", item: Board.model_name.human)
      @skincare_items = SkincareItem.all
      @skin_troubles = SkinTrouble.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to boards_path, success: t("defaults.flash_message.deleted", item: Board.model_name.human), status: :see_other
  end

  private

  def board_params
    params.require(:board).permit(:body, :board_image, :board_image_cache, :is_public, skincare_item_ids: [], skin_trouble_ids: [])
  end
end
