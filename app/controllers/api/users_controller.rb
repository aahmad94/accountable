class Api::UsersController < ApplicationController

  def index
    @users = User.all 
    render :index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render :show
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def search
    @users = User.search params[:query]
    render :index
  end

  def groups
    user_id = params[:id]
    groups = User.find(user_id).groups

    render json: groups.to_json
  end 

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
