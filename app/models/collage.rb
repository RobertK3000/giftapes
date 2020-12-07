class Collage < ApplicationRecord
  has_many :collage_items, inverse_of: :collage, dependent: :destroy
  has_one :giftape, as: :giftable
  accepts_nested_attributes_for :collage_items, allow_destroy: true
  # validates :name, presence: :true
end
