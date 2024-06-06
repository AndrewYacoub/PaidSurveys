# app/controllers/choices_controller.rb
class ChoicesController < ApplicationController
  before_action :set_category
  before_action :set_product
  before_action :set_survey
  before_action :set_question
  before_action :set_choice, only: [:edit, :update, :destroy]

  def index
    @choices = @question.choices
  end

  def new
    @choice = @question.choices.build
  end

  def create
    @choice = @question.choices.build(choice_params)
    if @choice.save
      redirect_to category_product_survey_question_choices_path(@category, @product, @survey, @question), notice: 'Choice was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @choice.update(choice_params)
      redirect_to category_product_survey_question_choices_path(@category, @product, @survey, @question), notice: 'Choice was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @choice.destroy
    redirect_to category_product_survey_question_choices_path(@category, @product, @survey, @question), notice: 'Choice was successfully destroyed.'
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
    @question = @survey.questions.find(params[:question_id])
  end

  def set_choice
    @choice = @question.choices.find(params[:id])
  end

  def choice_params
    params.require(:choice).permit(:content)
  end
end
