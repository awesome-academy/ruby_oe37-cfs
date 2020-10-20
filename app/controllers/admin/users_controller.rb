class Admin::UsersController < ApplicationController
  layout "application"

  def index
    @user_activate = User.activate
    @users = @user_activate.newest
      .user.paginate(page: params[:page]).per_page(Settings.user.page)
    respond_to do |format|
      format.html
      format.csv{send_data @user_activate.to_csv}
      format.xls{send_data @user_activate.to_csv}
    end
  end

  def show
    @categories = Category.where(user_id: params[:id]).newest.activate
      .paginate(page: params[:page]).per_page(Settings.user.page)
  end
end
