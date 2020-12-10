class QuizSession < ApplicationRecord
  belongs_to :quiz
  has_many :questions, through: :quiz
  has_many :answerings, dependent: :destroy
  has_many :answers, through: :answerings
  accepts_nested_attributes_for :answerings

  def build_answerings
    questions.each do |question|
      answerings.build(question: question)
    end
  end
end

