class AnswersController < ApplicationController


  def create
    @answer = Answer.new(answer_params)
    @answer.save
    redirect_to new_quiz_question_answer_path(@quiz)
  end

  def new
    @answer = Answer.new
  end

private

  def answer_params
    params.require(:answer).permit(:content, :is_correct?, :question_id)
  end
end


