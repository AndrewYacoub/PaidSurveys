# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController
  before_action :set_category
  before_action :set_product
  before_action :set_survey
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = @survey.questions
  end

  def new
    @question = @survey.questions.build
  end

  def create
    @question = @survey.questions.build(question_params)
    if @question.save
      redirect_to category_product_survey_questions_path(@category, @product, @survey), notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to category_product_survey_questions_path(@category, @product, @survey), notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to category_product_survey_questions_path(@category, @product, @survey), notice: 'Question was successfully destroyed.'
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_product
    @product = @category.products.find(params[:product_id])
  end

  def set_survey
    @survey = @product.surveys.find(params[:survey_id])
  end

  def set_question
    @question = @survey.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content)
  end
end
