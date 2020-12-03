class Answer < ApplicationRecord
  enum letter: [:a, :b, :c, :d]
  belongs_to :question
  ANSWERS = %w(A B C D)
end
