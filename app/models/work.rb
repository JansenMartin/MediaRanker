class Work < ApplicationRecord
  # Must have a category
  validates :category, presence: true

  # Must have a title
  validates :title, presence: true

  # Must have a creator
  validates :creator, presence: true
end
