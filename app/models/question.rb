class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers, dependent: :destroy
  validates :content, presence: :true
  # accepts_nested_attributes_for :quiz
end
