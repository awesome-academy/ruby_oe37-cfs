class SharesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  def index
    return @plans = Plan.none if params[:user_id].blank?

    @plans = Plan.where_by_user_id(params[:user_id])
      .where_by_month(params[:month])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @share = Share.new
  end

  def create
    @share = current_user.from_user_shares.build share_params
    if @share.save
      flash[:notice] = t ".success"
      redirect_to :new_share
    else
      flash.now[:danger] = t ".fails"
      render :new
    end
  end

  def get_month_from_user_shared
    month_by_from_user = Share
      .where_by_to_user_id(current_user)
      .where_by_from_user_id(params[:from_user_id])
    month = month_by_from_user.pluck(:month).uniq
    respond_to do |format|
      format.json{render json: month}
    end
  end

  private

  def share_params
    params.require(:share).permit :month, :to_user_id
  end
end
