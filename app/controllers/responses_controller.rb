# app/controllers/responses_controller.rb
class ResponsesController < ApplicationController
  def create
      @category = Category.find(params[:category_id])
      @product = @category.products.find(params[:product_id])
      @survey = @product.surveys.find(params[:survey_id])

      responses_params.each do |question_id, response_data|
        Response.create(
          user: current_user,
          survey: @survey,
          question_id: response_data[:question_id],
          choice_id: response_data[:choice_id]
        )
      end

      redirect_to category_product_survey_path(@category, @product, @survey), notice: 'Your responses have been submitted successfully.'
  end

    private

    def responses_params
      params.require(:responses).permit!
    end
end
  