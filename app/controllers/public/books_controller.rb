module Public
  class BooksController < ApplicationController
    skip_before_action :require_authentication

    def show
      @book = Book.find_by! slug: params[:slug]
      @leaves = @book.leaves.with_leafables.positioned
    end
  end
end
