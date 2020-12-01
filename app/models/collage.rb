class Collage < ApplicationRecord
  has_many :collage_items
  has_many :giftapes, as: :giftable
end
