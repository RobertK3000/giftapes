class Answering < ApplicationRecord
  belongs_to :quiz_session
  belongs_to :answer
  belongs_to :question

end
