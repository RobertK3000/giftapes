class Mixtape < ApplicationRecord
  validates :name, presence: true
  validates_presence_of :tracks, acceptance: {message: 'must have at least one track'}
  validates_associated :tracks, acceptance: {message: 'must have at least one track'}
  validate :at_least_one_track_in_mixtape

  has_many :tracks, -> {order(created_at: :asc)}, dependent: :destroy, inverse_of: :mixtape

  has_one :giftape, as: :giftable, dependent: :destroy
  accepts_nested_attributes_for :tracks, allow_destroy: true, reject_if: :all_blank

def at_least_one_track_in_mixtape
   errors.add(:base, 'You Mixtape needs at least one track.'
  ) if tracks.none?
end


end
