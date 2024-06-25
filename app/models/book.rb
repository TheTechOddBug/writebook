class Book < ApplicationRecord
  include Accessable, Sluggable

  has_many :leaves, dependent: :destroy
  has_one_attached :cover, dependent: :purge_later

  scope :ordered, -> { order(:title) }
  scope :published, -> { where(published: true) }

  enum :theme, { blue: 0, orange: 1, magenta: 2, green: 3, violet: 4, white: 5, black: 6 }, suffix: true

  def press(leafable, leaf_params)
    leaves.create! leaf_params.merge(leafable: leafable)
  end
end
