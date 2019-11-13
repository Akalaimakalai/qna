class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[ edit show update destroy ]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @question
    else
      errors = ""
      @answer.errors.full_messages.each { |m| errors += "-#{m}\n" }

      redirect_to @question, alert: errors
    end
  end

  def edit; end

  def show; end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_answers_path(@answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
