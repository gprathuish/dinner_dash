class OrdersController < ApplicationController
	before_action :authenticate_user
	layout :set_layout
	def set_layout
		current_user.is_admin ? "admin_layout" : "application"		
	end

  def index
  	@orders = current_user.orders.where(order_type: 1).order('created_at DESC')
  	@orders = Order.where("user_id IS NOT NULL and payment_status is not null").order('created_at DESC') if current_user.is_admin
  end

  def show
  	@order_items = Cart.where(order_id: params[:id])
  end
end
