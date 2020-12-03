class QuizzesController < ApplicationController

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.save
    Giftape.create(giftable: @quiz, user: current_user)
    redirect_to quiz_path(@quiz)
  end

  def new
    @quiz = Quiz.new
  end

  def show
    @quiz = Quiz.find(params[:id])
    @question = Question.new
  end

private

  def quiz_params
    params.require(:quiz).permit(:name)
  end
end
