class CategoriesController < ApplicationController
	before_action :set_category, only: [:show, :edit, :update, :destroy]  
  before_action :authenticate_admin

  layout 'admin_layout'
  def index    
  	@categories = Category.all
  end
  
  def new    
  	@category = Category.new
  end

  def create
  	@category = Category.new(category_params)
  	if @category.save
  		flash[:success] = "Category added successfuly..!"
  		redirect_to categories_path
  	else
  		flash.now[:danger] = "Opps..! Something went wrong..."
  		render 'new'
  	end
  end

  def show  	
  end

  def edit  	
  end

  def update  	
  	@category.update(category_params)
  	flash[:success] = "Category updated successfuly..!"
  	redirect_to category_path(@category.id)
  end

  def destroy
  	@category.destroy
  	flash[:success] = "Category removed successfuly..!"
  	redirect_to categories_path
  end

  private
  def set_category
  	@category = Category.find(params[:id])
  end

  def category_params
  	params.require(:category).permit(:name)  	
  end  

end
