class PagesController < ApplicationController
  include SetBookLeaf

  def index
  end

  def new
    @page = Page.new
  end

  def create
    leaf = @book.press new_page
    redirect_to @book
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def new_page
      Page.new params.require(:page).permit(:title, :body)
    end
end
