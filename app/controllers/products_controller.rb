# app/controllers/products_controller.rb
class ProductsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_category
    before_action :set_product, only: [:show, :edit, :update, :destroy]
  
    def index
      @products = @category.products
    end
  
    def show
      @category = Category.find(params[:category_id])
      @product = @category.products.find(params[:id])
      @surveys = @product.surveys

      respond_to do |format|
        format.html # default HTML response
        format.js   # JavaScript response
      end
    end
  
    def new
      @product = @category.products.build
    end
  
    def edit
    end
  
    def create
      @product = @category.products.build(product_params)
      if @product.save
        redirect_to category_product_path(@category, @product), notice: 'Product was successfully created.'
      else
        render :new
      end
    end
  
    def update
      if @product.update(product_params)
        redirect_to category_product_path(@category, @product), notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @product.destroy
      redirect_to category_path(@category), notice: 'Product was successfully destroyed.'
    end
  
    private
  
    def set_category
      @category = Category.find(params[:category_id])
    end
  
    def set_product
      @product = @category.products.find(params[:id])
    end
  
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
  end
  