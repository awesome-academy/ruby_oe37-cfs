class Category < ApplicationRecord
  belongs_to :user
  has_many :plans, dependent: :destroy

  enum delete_flag: {activate: 0, inactive: 1}
  scope :newest, ->{order(created_at: :desc)}

  validates :name, presence: true, length: {maximum: Settings.max_name}
end
