class Quiz < ApplicationRecord
  has_many :questions
  has_many :answers, through: :questions, dependent: :destroy
  has_many :giftapes, as: :giftable
  validates :name, presence: true

end
