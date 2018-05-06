class Api::GroupsController < ApplicationController
  def create
    # users ~ arr of users
    p "------------ GROUP PARAMS --------------"
    group_name = params[:group_name]
    p params
    user_ids = params[:user_ids]
    buy_in = params[:buy_in]

    @group = Group.new({"group_name": group_name, "buy_in": buy_in })
    @group.save
    
    user_ids.each do |user_id|
      @group.users << User.find(user_id)
    end 
  
    render :show
  end
end
