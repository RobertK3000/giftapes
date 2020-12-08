class Quiz < ApplicationRecord
  validates :name, presence: true
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions, dependent: :destroy
  has_many :quiz_sessions
  has_many :answerings, through: :quiz_sessions
  has_one :giftapes, as: :giftable, dependent: :destroy

end
