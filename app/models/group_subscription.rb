class GroupSubscription < ApplicationRecord
  validates :user_id, :group_id, presence: true 

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :group,
    primary_key: :id,
    foreign_key: :group_id,
    class_name: :Group

  has_one :challenge,
    primary_key: :id,
    foreign_key: :group_subscription_id,
    class_name: :Challenge
end
