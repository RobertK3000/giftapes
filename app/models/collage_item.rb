class CollageItem < ApplicationRecord
  belongs_to :collage, foreign_key: "collage_id", inverse_of: :collage_items
  validates_presence_of :collage
  has_one_attached :photo

  validates :prompt, :photo, presence: true
end