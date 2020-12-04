class Giftape < ApplicationRecord
  # Constant of giftable_types
  GIFTYPES = ['mixtape', 'quiz', 'curated_list', 'collage']

  belongs_to :giftable, polymorphic: true
  belongs_to :user

  def convert
    giftable_type.constantize.find(giftable_id)
  end

end
