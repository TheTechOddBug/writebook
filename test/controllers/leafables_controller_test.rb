require "test_helper"

class LeafablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in :kevin
  end

  test "create" do
    assert_changes -> { books(:handbook).leaves.count }, +1 do
      post book_pages_path(books(:handbook), format: :turbo_stream), params: {
        leaf: { title: "Another page" }, page: { body: "With interesting words." }
      }
    end

    assert_response :success
  end

  test "create requires editor access" do
    books(:handbook).access_for(user: users(:kevin)).update! level: :reader

    assert_no_changes -> { books(:handbook).leaves.count } do
      post book_pages_path(books(:handbook), format: :turbo_stream), params: {
        leaf: { title: "Another page" }, page: { body: "With interesting words." }
      }
    end

    assert_response :forbidden
  end
end
