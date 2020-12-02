class Giftape < ApplicationRecord
  belongs_to :giftable, polymorphic: true
  belongs_to :user

  def convert
    giftable_type.constantize.find(giftable_id)
  end

end
