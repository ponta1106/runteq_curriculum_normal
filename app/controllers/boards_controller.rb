class BoardsController < ApplicationController
  before_action :set_my_board, only: %i[edit update destroy]

  def index
    @boards = Board.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def bookmarks
    @bookmark_boards = current_user.bookmark_boards.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @board = Board.new
  end
  
  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: t('defaults.message.created', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Board.model_name.human)
      render :new
    end
  end

  def edit; end
  
  def update
    if @board.update(board_params)
      redirect_to board_path(@board), success: '掲示板を更新しました'
    else
      render :edit, danger: '掲示板を更新できませんでした'
    end
  end
  
  def destroy
    @board.destroy!
    redirect_to boards_path, success: '掲示板を削除しました'
  end
  
  private
  
  def set_my_board
    @board = current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body, :image, :image_cache)
  end
end
