class NotificationsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @categories = Category.order(created_at: :desc)
      @products = Product.order(created_at: :desc)
      @surveys = Survey.order(created_at: :desc)
      @filled_surveys = Response.includes(:survey, :user).order(created_at: :desc)
    end
  end