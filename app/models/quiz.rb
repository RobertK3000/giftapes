class Quiz < ApplicationRecord
  has_many :questions
  has_many :answers, through: :questions
  has_many :giftapes, as: :giftable
end
