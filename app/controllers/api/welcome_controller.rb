class Api::WelcomeController < ApplicationController
	def index
		if params[:id].present?
	  	category = Category.find(params[:id])
	  	items = category.items.includes(:pictures)
  	else  	
	  	items = Item.all.includes(:pictures)
	  end	  
	  render json: {success: true, items: items.order(:title)}
	end

	def show
		if params[:id].present?
			item = Item.find(params[:id])
			render json: {success: true, item: item}
		else
			render json: {success: false, message: "Item not found"}
		end		
	end

	def picture
		render json: { success: true, pictures: Picture.all.map{|x| {x.imageable_id => x.picture.url}} }
	end
end
