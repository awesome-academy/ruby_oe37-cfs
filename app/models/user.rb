class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :plans, dependent: :destroy
  attr_accessor :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest

  validates :full_name, presence: true, length: {maximum: Settings.max_full_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: {maximum: Settings.max_email},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.min_pass},
                                       allow_nil: true
  has_secure_password

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost: cost
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
