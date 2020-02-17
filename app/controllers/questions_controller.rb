class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def index
    @questions = Question.all
    @question = Question.new
    @answer = Answer.new
  end

  def show
    @question = Question.find(params[:id])
    @user = @question.user
    @answer = Answer.new
    @answers = @question.answers.all
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = '投稿しました'
      redirect_to question_path(@question.id)
    else
      flash[:danger] = '投稿に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy!
    redirect_to questions_path, success: '質問を削除しました'
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
