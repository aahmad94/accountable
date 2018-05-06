class Group < ApplicationRecord
  has_many :group_subscriptions,
    primary_key: :id,
    foreign_key: :group_id,
    class_name: :GroupSubscription

  has_many :users,
    through: :group_subscriptions
end
