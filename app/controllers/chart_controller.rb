class ChartController < ApplicationController
  before_action :find_plan_id_user, only: [:show, :index]
  before_action :authenticate_user!

  def index; end

  def show
    @income = @plans.group(:spending_category).group(:month)
      .income.sum(:moneys)
    @expenses = @plans.group(:spending_category).group(:month)
      .expenses.sum(:moneys)
  end

  private

  def find_plan_id_user
    @plans = current_user.plans
  end
end
