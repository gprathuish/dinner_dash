class RegistrationsController < ApplicationController
  layout 'admin_layout'
  def new
  	@user = User.new
  end

  def edit
  end

  def create
  	@user = User.new(params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :display_name))
  	if @user.save
      OrderMailer.registraion_confirmation(@user).deliver_later
  		flash[:success] = "Congratulations...! Registered Successfuly..."
  		redirect_to root_path
  	else
  		flash.now[:danger] = "Opps...! Registered faild..."
  		render 'new'
  	end
  	
  end
end
