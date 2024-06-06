module Book::DemoContent
  extend ActiveSupport::Concern

  included do
    after_create :create_demo_leaves
  end

  private
    def create_demo_leaves
      press demo_section, title: "Chapter 1"
      press demo_page, title: "My first page"
      press demo_picture, title: "Figure 1"
    end

    def demo_section
      Section.new
    end

    def demo_page
      Page.new(body: "# Welcome to Writebook. \n\nYour new book begins here.")
    end

    def demo_picture
      Picture.new(caption: "Inspiration is perishable", image: { io: demo_image, filename: "inspiration-is-perishable.png", content_type: "image/png" })
    end

    def demo_image
      File.open(Rails.root.join("app/assets/images/demo/inspiration-is-perishable.png"))
    end
end
