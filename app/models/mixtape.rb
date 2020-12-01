class Mixtape < ApplicationRecord
  has_many :tracks
  has_many :giftapes, as: :giftable
end
