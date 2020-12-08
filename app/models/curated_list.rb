class CuratedList < ApplicationRecord

  has_many :curated_list_items, dependent: :destroy
  has_one :giftape, as: :giftable, dependent: :destroy
  validates :name, presence: true

end
