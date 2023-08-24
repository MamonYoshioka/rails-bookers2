class BooksController < ApplicationController
  before_action :is_matching_login_user_book, only: [:edit, :update]

  # 新規登録画面
  def new
  end
  # 新規登録=>DBへ内容保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to @book
    else
      @books = Book.all
      render :index
    end
  end

  # 一覧表示
  def index
    @books = Book.all
    @book = Book.new

  end

  # 詳細ページ
  def show
    @book = Book.find(params[:id])
  end

  # 詳細編集ページ
  def edit
    @book = Book.find(params[:id])
  end
  # 編集内容更新処理
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to @book
    else
      render :edit
    end
  end

  # 削除機能
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  # ストロングパラメーター設定
  private
  def book_params
    params.require(:book).permit(:image, :title, :body)
  end

 def is_matching_login_user_book
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
 end

end
