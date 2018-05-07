class Challenge < ApplicationRecord
  belongs_to :group_subscription,
    primary_key: :id,
    foreign_key: :group_subscription_id,
    class_name: :GroupSubscription 

  has_one :user,
    through: :group_subscription

  has_one :group,
    through: :group_subscription
end
