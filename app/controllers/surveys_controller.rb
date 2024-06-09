# app/controllers/surveys_controller.rb
class SurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_action :set_category, except: [:index, :show, :edit, :create, :update, :destroy, :created]
  before_action :set_product, only: [:new, :show, :edit, :update, :destroy]

  def index
    @surveys = @product.surveys
  end

  def new
    @survey = Survey.new
  end

  def edit
  end

  def show
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:product_id])
    @survey = @product.surveys.find(params[:id])
    @questions = @survey.questions.includes(:choices)
    @wallet = current_user.wallet
    @bank_account = current_user.bank_accounts.first
  end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:product_id])
    @survey = @product.surveys.new(survey_params)
    @survey.category = @category
    @survey.user = current_user

    if @survey.save
      redirect_to [@category, @product, @survey], notice: 'Survey was successfully created.'
    else
      render :new
    end
  end

 def created
    @surveys = current_user.surveys

    if params[:search].present?
      @surveys = @surveys.where('title LIKE ? OR product_name LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:status].present?
      @surveys = @surveys.where(active: params[:status] == 'activated')
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
    @product = Product.find(params[:product_id])
  end

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(:title,:target_group, :about_publisher, :description, :reward, :start_date, :end_date, :active, questions_attributes: [:id, :content, :_destroy])
  end

  def response_params
    params.require(:response).permit(:survey_id, choice_ids: [])
  end
end
