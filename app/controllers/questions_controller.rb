class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :edit, :update]
  before_action :set_answer, only: [:index, :show]
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    @questions = Question.all
    @question = current_user.questions.build if current_user
  end

  def show
    @question = Question.find(params[:id])
    @user = @question.user
    @answers = @question.answers.all
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to question_path(@question.id), flash: { success: '投稿しました' }
    else
      redirect_to questions_path, flash: { danger: '投稿に失敗しました' }
    end
  end

  def destroy
    @question.destroy!
    redirect_to questions_path, flash: { success: '削除しました' }
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question.id), flash: { success: '質問を編集しました' }
    else
      redirect_to edit_question_path(@question.id), flash: { danger: '編集に失敗しました' }
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

  def set_question
    @question = current_user.questions.find(params[:id])
  end

  def set_answer
    @answer = current_user.answers.new if current_user
  end
end
