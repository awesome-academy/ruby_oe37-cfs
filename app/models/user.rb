class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  attr_accessor :remember_token, :activation_token, :reset_token

  before_create :create_activation_digest
  before_save   :downcase_email

  has_many :categories, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :from_user_shares, class_name: "Share",
    foreign_key: "from_user_id", dependent: :destroy
  has_many :to_user_shares, class_name: "Share",
    foreign_key: "to_user_id", dependent: :destroy

  validates :full_name, presence: true,
    length: {maximum: Settings.max_full_name}
  validates :email, presence: true,
    length: {maximum: Settings.max_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.min_pass},
    allow_nil: true

  has_secure_password

  enum delete_flag: {activate: 0, inactive: 1}
  enum role: {admin: 0, user: 1}
  scope :newest, ->{order created_at: :desc}

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

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_column :remember_digest, nil
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns reset_digest: User.digest(reset_token),
      reset_send_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_send_at < Settings.minutes.minutes.ago
  end

  def self.to_csv options = {}
    column_names = %w(full_name email activated created_at update_at)
    CSV.generate(options) do |csv|
      csv << column_names
      all.find_each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
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
