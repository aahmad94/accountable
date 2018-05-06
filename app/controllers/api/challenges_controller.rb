class Api::ChallengesController < ApplicationController
  def create
    p "---------- CHALLENGES PARAMS ---------- "
    p params

    name = params[:challenge][:name]
    description = params[:challenge][:description]
    verified = params[:challenge][:verified]
    expiration = params[:challenge][:expiration]

    user_id = params[:challenge][:user_id]
    group_id = params[:challenge][:group_id]

    
    group_subscription_id = GroupSubscription.where({ "user_id": user_id, "group_id": group_id }).pluck(:id)
    group_subscription_id = group_subscription_id[0]
    
    @challenge = Challenge.new({ "group_subscription_id": group_subscription_id, "name": name, "description": description, "verified": verified, "expiration": expiration })
    @challenge.save
    
    render :show 
  end 
end
