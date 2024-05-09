class Leaf < ApplicationRecord
  include Editable, Positionable, Status

  belongs_to :book
  positioned_within :book, association: :leaves

  delegated_type :leafable, types: Leafable::TYPES, dependent: :destroy
  delegate :title, to: :leafable

  scope :with_leafables, -> { includes(:leafable) }
end
