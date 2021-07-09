class BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)

  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end
end
