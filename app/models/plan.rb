class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum spending_category: {income: 0, expenses: 1}
  enum type_money: {fixed: 0, incurred: 1}
  enum status: {confirm: 0, unconfirm: 1}

  validates :moneys, presence: true,
    numericality: {greater_than_or_equal_to: Settings.min_money}

  scope :where_by_month, (lambda do |param_month|
    where(month: param_month) if param_month.present?
  end)

  scope :where_by_status, (lambda do |param_status|
    where(status: param_status) if param_status.present?
  end)

  delegate :name, to: :category, prefix: :category, allow_nil: true

  def self.spending_category_option
    spending_categories.map{|key, _value| [key.capitalize, key]}
  end

  def self.type_option
    type_moneys.map{|key, _value| [key.capitalize, key]}
  end

  def self.status_option
    statuses.map{|key, _value| [key.capitalize, key]}
  end

  def self.status_option_search
    statuses.map{|key, value| [key.capitalize, value]}
  end

  def self.to_csv options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.find_each do |plan|
        csv << plan.attributes.values_at(*column_names)
      end
    end
  end
end
