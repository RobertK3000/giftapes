class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions, dependent: :destroy
  has_many :quiz_sessions
  has_many :answerings, through: :quiz_sessions
  has_one :giftapes, as: :giftable
  validates :name, presence: true

end
