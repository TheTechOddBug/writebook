class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :set_users, only: %i[ new edit ]

  def index
    @books = Current.user.books.ordered
  end

  def new
    @book = Book.new
  end

  def create
    book = Current.user.books.editable.create! book_params
    update_accesses(book)

    redirect_to book
  end

  def show
    @leaves = @book.leaves.with_leafables.positioned
  end

  def edit
  end

  def update
    @book.update(book_params)
    update_accesses(@book)

    redirect_to @book
  end

  def destroy
    @book.destroy

    redirect_to root_url
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :subtitle, :author, :cover)
    end

    def set_users
      @users = User.active.ordered
    end

    def update_accesses(book)
      book.update_accesses(Array(params[:reader_ids]), Array(params[:editor_ids]), excluding: Current.user)
    end
end
