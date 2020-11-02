class Admin::UsersController < ApplicationController
  layout "application"
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :destroy]

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

  def destroy
    if @user.inactive!
      flash[:notice] = t "manger_user.user_deleted"
      redirect_to admin_users_path
    else
      flash.now[:alert] = t "manger_user.failed"
      render :index
    end
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:alert] = t "form.found"
    redirect_to signup_path
  end
end
