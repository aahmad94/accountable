require 'json'
require 'net/http'

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
      user = challenge.user.pluck(:id, :username)
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

  def pay
    group_id = params[:id]
    group = Group.find(group_id)

    buy_in = group["buy_in"]
    group.users.each do |user|
      group_subscription = GroupSubscription.where({ "user_id": user.attributes["id"], "group_id": group.attributes["id"]}).first
      group_member_challenge = group_subscription.challenge

      if group_member_challenge && !group_member_challenge["verified"]
        softheon_api(buy_in)
      end 

    end

  end

  def softheon_api(buy_in = 1, user = nil)
    uri = URI.parse("https://hack.softheon.io/api/payments/v1/payments")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request.add_field("Authorization", "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6Ijc2RkRDMUQ4RDlGRDYyQTZFNjZFQzE4MEVENzQ1NDZBRUI0RTBEODMiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJkdjNCMk5uOVlxYm1ic0dBN1hSVWF1dE9EWU0ifQ.eyJuYmYiOjE1MjU2MzQ3ODEsImV4cCI6MTUyNTYzODM4MSwiaXNzIjoiaHR0cHM6Ly9oYWNrLnNvZnRoZW9uLmlvL29hdXRoMiIsImF1ZCI6WyJodHRwczovL2hhY2suc29mdGhlb24uaW8vb2F1dGgyL3Jlc291cmNlcyIsInBheW1lbnRhcGkiXSwiY2xpZW50X2lkIjoiMjZiMjgzNDMtMGNjYy00ZWQzLTk1MzctZDYyMTM0ZWRhNDVlIiwic2NvcGUiOlsicGF5bWVudGFwaSJdfQ.tP7XJd-ePVZGQa9aei2wp0lb1WjZwWZcpAAUrjIBeS8v5rd0nsIXCMfJ4DhGgEJzQf433b7PwljJzNtIpf2tfX5eywpxL69Lq3Q4ekpyvCugiDDmkff53RIU7WvBR_09Qjq2SHFeboulQxKbw8r8j9Va-9YQO2QStpSB0A1GHR4tCEWCfMNKgLVieG-yocQApvZirIe3vwlZ9ZLNhO-4aVxkTxrpSHZcJQvD8DpAbUrmVHqZ4zwq2ybc1MJpyZ01LSLuot2O2TIxmAWYM2lUBS8l_1AiZcPSIwyghMQYR58Kk2tuOManyigIl2xpwHnwQN-ulPeRuR5XXplUx1uVk5oC91mZBREH97_4rMrbq5CHkhghMgLgcb_bQT83cBgs2X4zn84vS_yiJniZIL9nsVlR3UkKtnH9Sa4RQ6dalsEaRwmmPRaVePbRLtp2ANu9BiThVM_voa-o7lwDP5ddBcQtkpATSzHJWAUpy5X0QV1jSUdszCO3uLBXhdYgzey6ejYy5SByPRLoQYHz29jDBGfy2xXCRmFzt3DIP6hO4a7kB2FmdwA8R1dYqPFQNovVkdybUnYREfE_tefEC5WVKFcY5mk4u--wPwnTlwnm3Ws375UtA4eS3rHOMr_zH4RigdXzKuNf7y8HrQcNRJN4epU5sa-4rMWzMpB-nGc4i20")

    # in non-demo, each user would have a payment token that would be used here
    request.set_form_data(
      {
        "paymentAmount": buy_in,
        "description": "Payment of balance due",
        "referenceId": "example_payment",
        "paymentMethod": {
          "paymentToken": "4526724140624018",
          "type": "Credit Card"
        }
      }
    )
    response = http.request(request)
    response.code
  end
end 
