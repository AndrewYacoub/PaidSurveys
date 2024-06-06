# app/controllers/surveys_controller.rb
class SurveysController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_category
  before_action :set_product
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  def index
    @surveys = @product.surveys
  end

  def new
    @survey = @product.surveys.build
    @survey.questions.build  # Build an initial question for the form
  end

  def edit
  end

  def show
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:product_id])
    @survey = @product.surveys.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:product_id])
    @survey = @product.surveys.find(params[:survey_id])


    if @response.save
      redirect_to category_product_path(@category, @product), notice: 'Survey response submitted successfully.'
    else
      render :show
    end
  end

  def update
    if @survey.update(survey_params)
      redirect_to category_product_survey_path(@category, @product, @survey), notice: 'Survey was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @survey.destroy
    redirect_to category_product_surveys_path(@category, @product), notice: 'Survey was successfully destroyed.'
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_product
    @product = @category.products.find(params[:product_id])
  end

  def set_survey
    @survey = @product.surveys.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(:title, :description, :reward, :start_date, :end_date, :active, questions_attributes: [:id, :content, :_destroy])
  end

  def response_params
    params.require(:response).permit(:survey_id, choice_ids: [])
  end
end
