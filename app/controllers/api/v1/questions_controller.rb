class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :find_question, only: %i[ show update destroy ]

  authorize_resource

  def index
    @questions = Question.includes(:answers, :comments, :links, :user)
    render json: @questions
  end

  def show
    render json: @question
  end

  def create
    @question = current_resource_owner.questions.create!(question_params)
    render json: @question, status: 201
  end

  def update
    @question.update(question_params)
    render json: @question, status: 202
  end

  def destroy
    @question.destroy
    head 204
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
