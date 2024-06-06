module Book::Accesses
  extend ActiveSupport::Concern

  included do
    has_many :accesses, dependent: :destroy
    scope :with_everyone_access, -> { where(everyone_access: true) }
  end

  def accessable?(user: Current.user)
    accesses.exists?(user: user)
  end

  def editable?(user: Current.user)
    access_for(user: user)&.editor?
  end

  def access_for(user: Current.user)
    accesses.find_by(user: user)
  end

  def update_access(editors:, readers:)
    editors = Set.new(editors)
    readers = Set.new(everyone_access? ? User.active.ids : readers)

    all = editors + readers
    all_accesses = all.collect { |user_id|
      { user_id: user_id, level: editors.include?(user_id) ? :editor : :reader }
    }

    accesses.upsert_all(all_accesses, unique_by: [ :book_id, :user_id ])
    accesses.where.not(user_id: all).delete_all
  end
end
