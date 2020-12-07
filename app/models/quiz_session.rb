class QuizSession < ApplicationRecord
  belongs_to :quiz
  has_many :questions, through: :quiz
  has_many :answerings
  has_many :answers, through: :answerings
  # accepts_nested_attributes_for :answerings

  # #def answerings
  #   if persisted?
  #     super
  #   else
  #     questions.map do |question|
  #       Answering.new(question: question, quiz_session: self)
  #     end
  #   end
  # end
   def answerings_attributes=(values)
    questions.each do |question|
      answerings.build(question: question)
    end
  end
end

