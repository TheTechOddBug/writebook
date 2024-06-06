class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :set_users, only: %i[ new edit ]
  before_action :ensure_editable, only: %i[ edit update destroy ]

  def index
    @books = Current.user.books.ordered
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.create! book_params
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
    remove_cover if params[:remove_cover] == "true"

    redirect_to @book
  end

  def destroy
    @book.destroy

    redirect_to root_url
  end

  private
    def set_book
      @book = Current.user.books.find params[:id]
    end

    def set_users
      @users = User.active.ordered
    end

    def ensure_editable
      head :forbidden unless @book.editable?
    end

    def book_params
      params.require(:book).permit(:title, :subtitle, :author, :cover, :remove_cover, :everyone_access)
    end

    def update_accesses(book)
      editors = [ Current.user.id, *params[:editor_ids]&.map(&:to_i) ]
      readers = [ Current.user.id, *params[:reader_ids]&.map(&:to_i) ]

      book.update_access(editors: editors, readers: readers)
    end

    def remove_cover
      @book.cover.purge
    end
end
