class Category < ApplicationRecord
  belongs_to :user
  has_many :plans, dependent: :destroy
  enum delete_flag: {activate: 0, inactive: 1}
end
