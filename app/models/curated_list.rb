class CuratedList < ApplicationRecord

  has_many :curated_list_items, dependent: :destroy
  has_one :giftape, as: :giftable
  validates :name, presence: true

end
