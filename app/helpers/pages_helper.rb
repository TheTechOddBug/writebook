module PagesHelper
  def render_markdown(source)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(source).html_safe
  end

  def word_count(content)
    return if content.blank?
    pluralize content.split.size, "word"
  end

  def page_title(leaf, book)
    [ leaf.title, book.title, book.author ].reject(&:empty?).to_sentence(two_words_connector: " · ", words_connector: " · ", last_word_connector: " · ")
  end
end
