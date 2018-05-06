class Api::GroupsController < ApplicationController
  def create
    # users ~ arr of users
    group_name = params[:group][:group_name]
    user_ids = params[:group][:user_ids]
    buy_in = params[:group][:buy_in]

    @group = Group.new({"group_name": group_name, "buy_in": buy_in })
    @group.save
    
    user_ids.each do |user_id|
      @group.users << User.find(user_id)
    end 
  
    render :show
  end
end
