class User < ApplicationRecord
  before_validation :ensure_session_token

  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  # has_many :group_subscriptions,
  #   primary_key: :id,
  #   foreign_key: :user_id,
  #   class_name: :GroupSubscription,
  #   dependent: destroy

  # has_many :groups,
  #   through: :group_subscriptions

  # has_many :challenges,
  #   through: :group_subscriptions

  # ---------- Search ----------

  def self.search(query)
    self.where("username ILIKE ?", "%#{query}%")
  end

  # ---------- Auth stuff ----------
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

end