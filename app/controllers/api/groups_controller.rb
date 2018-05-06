class Api::GroupsController < ApplicationController
  def create
    # users ~ arr of users
    group_name = params[:group][:group_name]
    user_ids = params[:group][:user_ids]
    pool = params[:group][:pool]

    @group = Group.new({"group_name": group_name, "pool": pool })
    @group.save
    
    user_ids.each do |user_id|
      @group.users << User.find(user_id)
    end 
  
    render :show
  end
end
