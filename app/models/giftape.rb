class Giftape < ApplicationRecord
  belongs_to :giftable, polymorphic: true
  belongs_to :user
end
