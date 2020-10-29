class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_category, only: %i(new create)
  before_action :initialize_plan, only: %i(new create)
  before_action :plans_of_current_user, only: %i(index create)
  after_action :check_balance_after, only: %i(create)

  def index
    @search = plans_of_current_user.ransack params[:q]
    @plans = @search.result.order(:month)
    respond_to do |format|
      format.html
      format.js
      format.xls
    end
  end

  def new; end

  def create
    if check_balance_after.negative?
      flash.now[:alert] = t ".warning"
      render :new
    else
      @plan = current_user.plans.build plan_params
      if @plan.save
        flash[:notice] = t ".create_successfully"
        redirect_to :new_plan
      else
        render :new
      end
    end
  end

  def reload_categories
    categories = current_user.categories.activate.newest
    respond_to do |format|
      format.json{render json: categories}
    end
  end

  private

  def plan_params
    params.require(:plan).permit :month,
                                 :spending_category,
                                 :type_money,
                                 :status,
                                 :moneys,
                                 :category_id
  end

  def initialize_category
    @category = Category.new
  end

  def initialize_plan
    @plan = Plan.new
  end

  def plans_of_current_user
    current_user.plans
  end

  def check_balance_after
    return 1 if params[:plan][:spending_category] == "income"

    load_balance - params[:plan][:moneys].to_f
  end

  def load_balance
    total_income_moneys = plans_of_current_user.income.confirm
      .where_by_month(params[:plan][:month]).sum(:moneys)
    total_expenses_moneys = plans_of_current_user.expenses.confirm
      .where_by_month(params[:plan][:month]).sum(:moneys)
    total_income_moneys - total_expenses_moneys
  end
end
