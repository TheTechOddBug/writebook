require "test_helper"

class MarkdownRendererTest < ActiveSupport::TestCase
  test "it generates unique IDs for headers" do
    markdown = MarkdownRenderer.build
    content = "# Header 1\n\n## Duplicated Header\n\n### Duplicated header\n\n"
    assert_equal "<h1 id='header-1'>Header 1</h1><h2 id='duplicated-header'>Duplicated Header</h2><h3 id='duplicated-header-2'>Duplicated header</h3>",
      markdown.render(content)
  end
end
