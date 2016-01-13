class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_path, only: :authenticate_admin
  
  include CurrentCart
  #protect_from_forgery with: :exception
  before_action :set_cart
  helper_method :current_user, :cart_count, :current_cart

  def cart_count
    Cart.where(order_id: current_cart.id).count
  end
  
  def current_cart
    current_cart ||= Order.find(session[:order_id])
  end

  def authenticate_admin
    if current_user.present?
      unless current_user.is_admin
        flash[:warning] = "You don't have permissions"
        redirect_to root_path 
      end
    else
      flash[:warning] = "You should login"
      redirect_to login_path
    end
  end

  def authenticate_user
  	unless current_user.present?
  		flash[:warning] = "You should login" 
      set_path 		
      redirect_to login_path
  	end
  end

  def set_path
    session[:redirect_to] = request.fullpath
  end

  private
  def current_user
  	current_user ||= User.find_by id: session[:user_id] if session[:user_id]  	
  end
end
