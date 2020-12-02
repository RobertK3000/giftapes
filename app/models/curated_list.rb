class CuratedList < ApplicationRecord

  has_many :curated_list_items
  has_one :giftape, as: :giftable


end
