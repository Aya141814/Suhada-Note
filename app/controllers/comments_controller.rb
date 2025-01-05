class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end
  def edit
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end
