module LeavesHelper
  def leaf_nav_tag(leaf, **options, &block)
    tag.nav data: {
      controller: "reading-tracker",
      reading_tracker_book_id_value: leaf.book_id,
      reading_tracker_leaf_id_value: leaf.id
    }, **options, &block
  end
end
