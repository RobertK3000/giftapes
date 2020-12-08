class Question < ApplicationRecord
  validates :content, presence: true
  belongs_to :quiz
  has_many :answers, dependent: :destroy
  # accepts_nested_attributes_for :quiz
end
