class Api::ChallengesController < ApplicationController
  def create
    name = params[:name]
    description = params[:description]
    verified = params[:verified]
    expiration = params[:expiration]

    user_id = params[:user_id]
    group_id = params[:group_id]

    
    group_subscription_id = GroupSubscription.where({ "user_id": user_id, "group_id": group_id }).pluck(:id)
    group_subscription_id = group_subscription_id[0]
    
    @challenge = Challenge.new({ "group_subscription_id": group_subscription_id, "name": name, "description": description, "verified": verified, "expiration": expiration })
    @challenge.save

    render :show 
  end 

  def update
    @challenge = Challenge.find(params[:id])
    @challenge.update({ "verified": "true" })
    
    render :show
  end 
end
