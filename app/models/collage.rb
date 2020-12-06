class Collage < ApplicationRecord
  has_many :collage_items, inverse_of: :collage, dependent: :destroy
  has_one :giftape, as: :giftable
  accepts_nested_attributes_for :collage_items, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: :true
  validates_presence_of :collage_items, acceptance: {message: 'Must have at least one photo'}
  validates_associated :collage_items, acceptance: {message: 'Must have at least one photo'}
end
