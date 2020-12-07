class QuizzesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

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

  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy
    redirect_to my_giftapes_path
  end

private

  def quiz_params
    params.require(:quiz).permit(:name)
  end
end
