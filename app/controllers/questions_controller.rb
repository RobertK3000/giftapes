class QuestionsController < ApplicationController

  def create
    @quiz = Quiz.find(params[:quiz_id])
    @question = Question.new(question_params)
    @question.quiz = @quiz
    if @question.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to quiz_url(@question.quiz)
  end

private

  def question_params
    params.require(:question).permit(:content, :quiz_id)
  end

end
