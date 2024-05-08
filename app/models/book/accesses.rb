module Book::Accesses
  extend ActiveSupport::Concern

  included do
    has_many :accesses, dependent: :destroy
  end

  def accessable?(user: Current.user)
    accesses.exists?(user: user)
  end

  def editable?(user: Current.user)
    access_for(user: user)&.editor?
  end

  def readonly?(user: Current.user)
    access_for(user: user)&.reader?
  end

  def access_for(user: Current.user)
    accesses.find_by(user: user)
  end

  def update_accesses(reader_ids, editor_ids, excluding:)
    update_access_levels(reader_ids, :reader)
    update_access_levels(editor_ids, :editor)

    exclude_ids = Array(excluding).map(&:id)
    accesses.where.not(user_id: reader_ids + editor_ids + exclude_ids).delete_all
  end

  private
    def update_access_levels(user_ids, level)
      user_ids.each do |user_id|
        accesses.find_or_initialize_by(user_id: user_id).update! level: level
      end
    end
end
