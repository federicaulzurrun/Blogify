class UsersController < ApplicationController
  def index 
    @users = User.all
  end

  def show
    @user = User.find(params[:id]) || not_found
  end
end
