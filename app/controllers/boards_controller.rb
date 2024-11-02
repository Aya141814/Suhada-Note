class BoardsController < ApplicationController
  def index
    @boards = Board.includes(:users)
  end
end
