class SessionsController < ApplicationController
  layout 'admin_layout'
  def new
  	#flash[:danger] = ""
  end

  def create
  	user = User.find_by email: params[:email]  	
  	#raise params[:password].inspect;
  	#raise user.authenticate(params[:password][0]).inspect 	

    if user && user.authenticate(params[:password][0])
      if user.status
        flash[:info] = "Congratulation..! Successfuly loged in.."
        session[:user_id] = user.id
        current_cart.update(user_id: user.id)
        if session[:redirect_to]
          redirect_to session.delete(:redirect_to)
        else
          redirect_to root_path  
        end
        
      else
        flash.now[:warning] = "You are blocked by Admin"
        render 'new'       
      end
  		
  	else
  		flash.now[:danger] = "Oops..! Invalide Email/Password"
  		render 'new'
  	end
  end

  def destroy
    order = Order.find(session[:order_id])
    unless order #check items are there or not
      order.destroy
    end
    session[:order_id], session[:user_id] = nil
  	flash[:info] = "You are now loged out..!"
  	redirect_to root_path
  end
end
