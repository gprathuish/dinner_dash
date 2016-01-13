class UsersController < ApplicationController
	before_action :authenticate_admin
	layout 'admin_layout'
  def index  	
  	users = User.all
  	@users = users - [current_user]
  end

  def destroy
  	User.find(params[:id]).destroy
  	redirect_to users_path
  end

  def status_toggle  	
  	user = User.find(params[:id])
  	user.status = !user.status
  	user.save
  	redirect_to users_path
  end
end
