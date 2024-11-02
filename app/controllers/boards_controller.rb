class BoardsController < ApplicationController
  def index
    @boards = Board.includes(:users)
  end

  def new
    @board = Board.new
  end
end
