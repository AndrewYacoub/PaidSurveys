# app/controllers/statistics_controller.rb
class StatisticsController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @product_statistics = Product.joins(:surveys)
                                   .select('products.*, COUNT(surveys.id) AS survey_count')
                                   .group('products.id')
  
      @survey_statistics = Survey.joins(questions: :responses)
                                 .select('surveys.*, COUNT(responses.id) AS response_count')
                                 .group('surveys.id')
  
      @choice_statistics = Choice.joins(:responses)
                                 .select('choices.*, COUNT(responses.id) AS response_count')
                                 .group('choices.id')
    end
  end
  