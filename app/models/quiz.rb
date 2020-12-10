class Quiz < ApplicationRecord
  validates :name, presence: true
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions, dependent: :destroy
  has_many :quiz_sessions, dependent: :destroy
  has_many :answerings, through: :quiz_sessions
  has_one :giftape, as: :giftable, dependent: :destroy

end
