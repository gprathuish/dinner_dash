class WelcomeController < ApplicationController
  before_action :set_path
  def index  
  	# raise params.inspect
  	if params[:id].present?
	  	category = Category.find(params[:id])
	  	items = category.items.includes(:pictures)
  	else  	
	  	items = Item.all.includes(:pictures)
	  end
	  @items = items.order(:title)
  end


  def show
  	# raise params.inspect
  	@item = Item.find(params[:id])  	
  end
end
