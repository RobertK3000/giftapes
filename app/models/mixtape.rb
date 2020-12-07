class Mixtape < ApplicationRecord
  validates :name, :theme_type, presence: true
  validates_presence_of :tracks, acceptance: {message: 'must have at least one track'}
  validates_associated :tracks, acceptance: {message: 'must have at least one track'}
  validate :at_least_one_track_in_mixtape

  has_many :tracks, dependent: :destroy, inverse_of: :mixtape

  has_one :giftapes, as: :giftable
  accepts_nested_attributes_for :tracks, allow_destroy: true, reject_if: :all_blank

def at_least_one_track_in_mixtape
   errors.add(:base, 'You Mixtape needs at least one track.'
  ) if tracks.none?
end


end
