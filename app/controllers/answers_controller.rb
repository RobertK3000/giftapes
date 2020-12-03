class AnswersController < ApplicationController

def create
    @question = Question.find(params[:question_id])
    @answers = content_params.keys
    @answers.each do |letter|
      if letter == answer_params["letter"].downcase
        Answer.create(content: content_params[letter], is_correct: true, letter: letter, question_id: @question.id)
      else
        Answer.create(content: content_params[letter], is_correct: false, letter: letter, question_id: @question.id)
      end
    end

    redirect_to quiz_url(@question.quiz)
   rescue
    render :new

end

  def new
    @answer = Answer.new
  end

private

  def answer_params
    params.require(:answer).permit(:content, :is_correct?, :question_id, :letter)
  end

  def content_params
     params.require(:other).permit(:a, :b, :c, :d)
  end
end
