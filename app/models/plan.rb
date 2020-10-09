class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum income_expenses_type: {income: 0, expenses: 1}
  enum fixed_incurred_type: {fixed: 0, incurred: 1}
end
