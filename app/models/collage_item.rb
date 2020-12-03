class CollageItem < ApplicationRecord
  belongs_to :collage, foreign_key: "collage_id"
  has_one_attached :photo

  validates :prompt, presence: true
  validates :photo, presence: true
end
