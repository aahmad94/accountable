require 'json'
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

  def challenges
    result = []
    temp = {}
    group_id = params[:id]
    Group.find(group_id).challenges.each do |challenge| 
      user = challenge.users.pluck(:id, :username)
      p challenge
      if user.length > 0
        temp["user"] = { "id": user[0][0], "username": user[0][1] }
      else 
        temp["user"] = {}
      end 
      temp["challenge"] = challenge.as_json
      
      result.push(temp)
      temp = {}
    end
    render json: result.uniq.to_json
  end
end
