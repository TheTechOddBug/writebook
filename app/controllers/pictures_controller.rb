class PicturesController < ApplicationController
  include SetBookLeaf

  def new
    @picture = Picture.new
  end

  def create
    @leafable = new_picture
    @book.press @leafable

    respond_to do |format|
      format.turbo_stream { render }
      format.html { redirect_to @book }
    end
  end

  def show
  end

  def edit
  end

  def update
    @leaf.edit picture_params
    redirect_to @book
  end

  def destroy
    @leaf.trashed!
    redirect_to @book
  end

  private
    def new_picture
      Picture.new picture_params
    end

    def picture_params
      params.require(:picture).permit(:title, :image)
    end
end
