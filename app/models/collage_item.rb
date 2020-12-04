class CollageItem < ApplicationRecord
  belongs_to :collage, foreign_key: "collage_id"
  has_one_attached :photo

  validates :prompt, :photo, presence: true
end
