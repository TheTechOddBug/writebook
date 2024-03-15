class Book < ApplicationRecord
  has_many :leafs, dependent: :destroy

  scope :ordered, -> { order(:title) }

  def press(leafable)
    transaction do
      leafable.save!
      leafs.create! leafable: leafable
    end
  end
end
