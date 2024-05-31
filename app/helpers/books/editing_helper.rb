module Books::EditingHelper
  def editing_mode_toggle_switch(leaf: nil)
    edit_url = edit_leafable_path(leaf) if leaf
    read_url = leafable_path(leaf) if leaf
    render "books/edit_mode", edit_url: edit_url, read_url: read_url
  end
end
