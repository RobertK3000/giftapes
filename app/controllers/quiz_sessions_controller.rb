class QuizSessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  # /quizzes/4/quiz_sessions
  def create
    @quiz = Quiz.find(params[:quiz_id])
    @quiz_session = QuizSession.new(quiz_session_params)
    @quiz_session.quiz = @quiz
    raise
  end

  private

  def quiz_session_params
    params.require(:quiz_session).permit(answerings_attributes: [:answer_id, :question_id])
  end
end
