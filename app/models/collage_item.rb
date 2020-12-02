class CollageItem < ApplicationRecord
  belongs_to :collage
  has_one_attached :photo

  validates :prompt, presence: true
  validates :photo, presence: true
end
