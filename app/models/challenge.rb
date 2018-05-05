class Challenge < ApplicationRecord
  belongs_to :group_subscription,
    primary_key: :id,
    foreign_key: :group_subscription_id,
    class_name: :GroupSubscription 

    belongs_to :user,
      through: :group_subscription
end
