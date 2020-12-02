class Mixtape < ApplicationRecord
  validates :name, :theme_type, presence: true

  has_many :tracks, inverse_of: :mixtape
  has_many :giftapes, as: :giftable
  accepts_nested_attributes_for :tracks, allow_destroy: true, reject_if: proc { |attrs| attrs['youtube_url'].blank? }

end
