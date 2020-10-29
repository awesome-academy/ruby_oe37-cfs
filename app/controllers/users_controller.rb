class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:edit, :update]

  # def show; end

  # # def new
  # #   @user = User.new
  # # end

  # # def create
  # #   @user = User.new(user_params)
  # #   if @user.save
  # #     @user.send_activation_email
  # #     UserMailer.account_activation(@user).deliver_now
  # #     flash[:info] = t "form.create"
  # #     redirect_to root_url
  # #   else
  # #     render :new
  # #   end
  # # end

  def edit; end

  def update
    @user.member!
    flash[:notice] = t "edit.edit_success"
    SendMailUpgradeWorker.perform_async @user.id
    redirect_to root_path
  end

  # def destroy
  #   if current_user.admin?
  #     @user.inactive!
  #     flash[:success] = t "manger_user.user_deleted"
  #     redirect_to admin_users_path
  #   else
  #     flash.now[:danger] = t "manger_user.failed"
  #     render :index
  #   end
  # end

  private

  # def user_params
  #   params.require(:user).permit(:full_name, :email, :password,
  #                                :password_confirmation, :reason)
  # end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:alert] = t "form.found"
    redirect_to root_path
  end

  # def admin_user
  #   redirect_to(root_url) unless current_user.role?
  # end
end
