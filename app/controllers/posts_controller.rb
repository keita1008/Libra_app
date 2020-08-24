class PostsController < ApplicationController

  before_action :authenticate_user

  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @books = Book.all.order(created_at: :desc)
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find_by(id: params[:id])
    @user = @book.user
    @like_count = Like.where(book_id: @book.id).count
  end

  def create
    @book = Book.new(
        title: params[:title],
        content: params[:content],
        user_id: @current_user.id
    )
    if @book.save
       flash[:notice] = "投稿を作成しました"
       redirect_to("/posts/index")
    else
       @error_message = "タイトルまたは感想が空欄です"
       render("posts/new")
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def update
    @book = Book.find_by(id: params[:id])
    @book.title = params[:title]
    @book.content = params[:content]
    if @book.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @book = Book.find_by(id: params[:id])
    @book.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @book = Book.find_by(id: params[:id])
    if @book.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  # private
  # def book_params
  #   params.permit(:title, :content)
  # end
end
