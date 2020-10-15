class SharesController < ApplicationController
  def new
    @share = Share.new
  end

  def create
    @share = current_user.from_user_shares.build share_params
    if @share.save
      flash[:success] = t ".success"
      redirect_to :new_share
    else
      flash.now[:danger] = t ".fails"
      render :new_share
    end
  end

  private

  def share_params
    params.require(:share).permit :month,
                                  :to_user_id
  end
end
