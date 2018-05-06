class Challenge < ApplicationRecord
  belongs_to :group_subscription,
    primary_key: :id,
    foreign_key: :group_subscription_id,
    class_name: :GroupSubscription 

    has_many :users,
      through: :group_subscription

    has_many :groups,
      through: :group_subscription
end
