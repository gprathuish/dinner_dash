class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_admin
  before_action :set_path

  layout 'admin_layout'
  def index
  	@items = Item.all.includes(:categories)
  end

  def new
  	@item = Item.new 
    # @item.pictures.build  
  end

  def create
  	# raise params.inspect
  	@item = Item.new(item_params)        

  	if @item.save  
      # raise @item.categories_items.inspect
      # raise @item.pictures.inspect
      flash[:success] = "Item Created successfully..."
  		redirect_to items_path
  	else
  		flash.now[:danger] = "Opps..! Faild creating item..."
  		render 'new'
  	end
  end

  def show  	
  end

  def edit   
    
  end

  def update
  	@item.update(item_params)
    # @item.pictures.first.update(name: params[:item][:name].original_filename)
  	flash[:success] = "Successfully created..."
  	redirect_to items_path  	
  end

  def destroy
    #raise params[:id].inspect
  	@item.destroy
  	flash[:success] = "Item Removed Successfully..."
  	redirect_to items_path
  end

  private
  def set_item    
  	@item = Item.find(params[:id])
  end

  def item_params
  	params.require(:item).permit(:title,:price, :description,:item_type, pictures_attributes: [:id, :picture], categories_items_attributes: [:id,:category_id, :_destroy])
  end
  
    
end