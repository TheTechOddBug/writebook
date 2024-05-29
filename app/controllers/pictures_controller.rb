class PicturesController < LeafablesController
  private
    def leafable_class
      Picture
    end

    def leafable_params
      params.fetch(:picture, {}).permit(:image)
    end
end
