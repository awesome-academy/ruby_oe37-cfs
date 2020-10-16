module PlansHelper
  def load_categories
    @categories = current_user.categories.activate
  end

  def total_income
    @plans.income.sum(:moneys)
  end

  def total_expenses
    @plans.expenses.sum(:moneys)
  end

  def difference
    total_income - total_expenses
  end
end
