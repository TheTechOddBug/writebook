module Leaf::Editable
  extend ActiveSupport::Concern

  included do
    has_many :edits, dependent: :delete_all

    after_update :record_moved_to_trash, if: :was_trashed?
  end

  def edit(leafable_params: {}, leaf_params: {})
    transaction do
      changes_to_leafable = leafable_params.select do |key, value|
        leafable.attributes[key.to_s] != value
      end

      if changes_to_leafable.present?
        new_leafable = leafable.dup_with_attachments
        new_leafable.update!(leafable_params)
        edits.revision.create!(leafable: leafable)
        update! leaf_params.merge(leafable: new_leafable)
      else
        update! leaf_params
      end
    end
  end

  private
    def record_moved_to_trash
      edits.trash.create!(leafable: leafable)
    end

    def was_trashed?
      trashed? && previous_changes.include?(:status)
    end
end
