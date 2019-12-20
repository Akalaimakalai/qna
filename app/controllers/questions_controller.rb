class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :load_question, only: %i[ show edit update destroy create_vote ]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @answer.links.new
  end

  def new
    @question = Question.new
    @question.links.new
    @question.medal = Medal.new
  end

  def edit; end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    @question.update(question_params) if current_user.is_author?(@question)
  end

  def destroy
    if current_user.is_author?(@question)
      @question.destroy
      redirect_to questions_path
    else
      redirect_to @question, alert: 'You must be an author of the question to delete it.'
    end
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [:name, :url, :_destroy, :id], medal_attributes: [:name, :image])
  end

  def vote_params
    vote_hash = params[:vote].permit(:value)
    vote_hash[:user_id] = current_user.id
    vote_hash
  end
end
