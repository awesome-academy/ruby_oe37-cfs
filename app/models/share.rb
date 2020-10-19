class Share < ApplicationRecord
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"

  scope :where_by_from_user_id, (lambda do |param_from_user_id|
    where(from_user_id: param_from_user_id) if param_from_user_id.present?
  end)

  scope :where_by_to_user_id, (lambda do |param_to_user_id|
    where(to_user_id: param_to_user_id) if param_to_user_id.present?
  end)

  delegate :email, to: :user, allow_nil: true
end
