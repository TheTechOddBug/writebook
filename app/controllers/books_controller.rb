class BooksController < ApplicationController
  before_action :set_book, only: %i[ show ]

  def index
    @books = Book.ordered
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.create! book_params
    redirect_to book
  end

  def show
    @leafs = @book.leafs.with_leafables
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title)
    end
end
