module BooksHelper
  def link_to_previous_leafable(leaf)
    if previous_leaf = leaf.previous
      link_to "≪ " + previous_leaf.title, leafable_path(previous_leaf), data: { **hotkey_data_attributes("left") }
    end
  end

  def link_to_next_leafable(leaf)
    if next_leaf = leaf.next
      link_to next_leaf.title + " ≫", leafable_path(next_leaf), data: { **hotkey_data_attributes("right") }
    end
  end

  private
    def hotkey_data_attributes(key)
      { controller: "hotkey", action: "keydown.#{key}@document->hotkey#click" }
    end
end
