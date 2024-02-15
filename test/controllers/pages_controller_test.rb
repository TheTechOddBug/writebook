require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    get new_book_page_path(books(:handbook))
    assert_response :ok

    post book_pages_path(books(:handbook)), params: { page: { title: "Another page", body: "With interesting words." } }
    assert_redirected_to books(:handbook)

    new_page = Page.last
    assert_equal "Another page", new_page.title
    assert_equal "With interesting words.", new_page.body
    assert_equal books(:handbook), new_page.leaf.book
  end

  test "update" do
    get edit_leafable_path(leafs(:welcome_page))
    assert_response :ok

    put leafable_path(leafs(:welcome_page)), params: { page: { title: "Better welcome", body: "With even more interesting words." } }
    assert_redirected_to books(:handbook)

    updated_page = leafs(:welcome_page).reload.page
    assert_equal "Better welcome", updated_page.title
    assert_equal "With even more interesting words.", updated_page.body
  end
end
