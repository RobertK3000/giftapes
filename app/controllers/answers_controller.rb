class AnswersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

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

  def show
    @quiz = Quiz.find(params[:quiz_id])
    @questions = Question.all.count

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
