module BooksHelper
  def link_to_previous_leafable(leaf)
    if previous_leaf = leaf.previous
      link_to leafable_path(previous_leaf), data: { **hotkey_data_attributes("left") }, class: "flex align-center gap full-width flex-item-grow min-width justify-start" do
        tag.span(class: "btn") do
          image_tag("arrow-left.svg", aria: { hidden: true }, size: 24) + tag.span("Previous", class: "for-screen-reader")
        end + tag.span(previous_leaf.title, class: "overflow-ellipsis")
      end
    end
  end

  def link_to_next_leafable(leaf)
    if next_leaf = leaf.next
      link_to leafable_path(next_leaf), data: { **hotkey_data_attributes("right") }, class: "flex align-center gap full-width flex-item-grow min-width justify-end" do
        tag.span(next_leaf.title, class: "overflow-ellipsis") +
        tag.span(class: "btn") do
          image_tag("arrow-right.svg", aria: { hidden: true }, size: 24) + tag.span("Next", class: "for-screen-reader")
        end
      end
    end
  end

  private
    def hotkey_data_attributes(key)
      { controller: "hotkey", action: "keydown.#{key}@document->hotkey#click" }
    end
end
