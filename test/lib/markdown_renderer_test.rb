require "test_helper"

class MarkdownRendererTest < ActiveSupport::TestCase
  test "it generates unique IDs for headers" do
    markdown = MarkdownRenderer.build
    content = markdown.render("# Header 1\n\n## Duplicated Header\n\n### Duplicated header\n\n")

    assert_includes content, "id='duplicated-header'"
    assert_includes content, "id='duplicated-header-2'"
  end

  test "it escapes image attributes" do
    markdown = MarkdownRenderer.build
    content = markdown.render(%(![a "b"](/image.png "x" data-x="y")))

    assert_includes content, %(title="x&quot; data-x=&quot;y")
    assert_includes content, %(alt="a &quot;b&quot;")
    assert_empty Nokogiri::HTML5.fragment(content).css("[data-x]")
  end
end
