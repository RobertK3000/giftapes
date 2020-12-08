class Collage < ApplicationRecord
  has_many :collage_items, inverse_of: :collage, dependent: :destroy
  has_one :giftape, as: :giftable

  accepts_nested_attributes_for :collage_items, allow_destroy: true
  validates_associated :collage_items
  validates :name, presence: :true

  # validate :needs_one_collage_item
  # def needs_one_collage_item
  #   errors.add(:collage_items, 'Please add at least one item') if collage_items.none?
  # end

end
