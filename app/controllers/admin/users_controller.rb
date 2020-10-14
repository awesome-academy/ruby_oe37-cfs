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
    load_categories_of_user
    render :index
  end
end
