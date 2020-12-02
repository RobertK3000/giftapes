class Collage < ApplicationRecord
  has_many :collage_items, inverse_of: :collage
  has_many :giftapes, as: :giftable
  accepts_nested_attributes_for :collage_items
end
