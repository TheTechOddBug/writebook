class Leaf < ApplicationRecord
  belongs_to :book

  delegated_type :leafable, types: Leafable::TYPES, dependent: :destroy
  delegate :title, to: :leafable

  scope :with_leafables, -> { includes(:leafable) }
end
