class Api::UsersController < ApplicationController
	def registration
		@user = User.new(params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :display_name))
  	if @user.save
      OrderMailer.registraion_confirmation(@user).deliver_later  		
  		render :json => {success: true, user: @user}
  	else
  		render :json => {success: false, message: @user.errors.full_messages}  		
  	end
	end	

	def login
		user = User.find_by email: params[:email]
  	
    if user && user.authenticate(params[:password])
      if user.status        
        session[:user_id] = user.id
        render :json => {success: true, user: user}        
      else
        render :json => {:success=>false, :message => "You are blocked by Admin"}
      end  		
  	else
  		render :json => {:success=>false, :message => "Invalid email/Password"}
  	end	
	end

	def logout
		order = Order.find(session[:order_id])
    unless order #check items are there or not
      order.destroy
    end
    session[:order_id], session[:user_id] = nil
  	render :json => {success: true, message: "Successfuly loged out"}        
	end
end
