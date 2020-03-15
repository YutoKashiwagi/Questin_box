class StocksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_question, only: [:create, :destroy]
  def index
    @user = User.find(params[:user_id])
    @questions = @user.stocked_questions.recent.page(params[:page]).per(10)
  end

  def create
    current_user.stock(@question)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def destroy
    current_user.unstock(@question)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  private

  def set_question
    @question = Question.find(params[:stock][:question_id])
  end
end
