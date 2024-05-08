require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in :kevin
  end

  test "index lists the current user's books" do
    get books_url

    assert_response :success
    assert_select "h2", text: "Handbook"
    assert_select "h2", text: "Manual", count: 0
  end

  test "create makes the current user an editor" do
    assert_difference -> { Book.count }, +1 do
      post books_url, params: { book: { title: "New Book" } }
    end

    assert_redirected_to book_url(Book.last)

    book = Book.last
    assert_equal "New Book", book.title
    assert_equal 1, Book.last.accesses.count

    assert book.editable?(user: users(:kevin))
  end

  test "create sets additional accesses" do
    assert_difference -> { Book.count }, +1 do
      post books_url, params: { book: { title: "New Book" }, "editor_ids[]": users(:jz).id, "reader_ids[]": users(:jason).id }
    end

    book = Book.last
    assert_equal "New Book", book.title
    assert_equal 3, Book.last.accesses.count

    assert book.editable?(user: users(:jz))
    assert book.readonly?(user: users(:jason))
  end

end
