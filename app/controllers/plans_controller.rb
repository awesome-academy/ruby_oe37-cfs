class PlansController < ApplicationController
  def index
    @plans = current_user.plans
      .where_by_status(params[:status])
      .where_by_month(params[:month]).order(:month)
    respond_to do |format|
      format.html
      format.js
      format.xls
    end
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_user.plans.build plan_params
    if @plan.valid?
      if @plan.save
        flash[:success] = t ".create_successfully"
      else
        flash[:danger] = t ".error"
      end
      redirect_to :new_plan
    else
      render :new
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
end
