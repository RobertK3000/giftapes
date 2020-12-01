class CuratedList < ApplicationRecord
  has_many :curated_list_items
  has_many :giftapes, as: :giftable
end
