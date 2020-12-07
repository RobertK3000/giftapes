class Giftape < ApplicationRecord
  # Constant of giftable_types
  GIFTYPES = ['mixtape', 'quiz', 'curated_list', 'collage']

  belongs_to :giftable, polymorphic: true
  belongs_to :user

  validates :custom_url, uniqueness: true

  def to_param
    custom_url
  end

  def convert
    giftable_type.constantize.find(giftable_id)
  end

end
