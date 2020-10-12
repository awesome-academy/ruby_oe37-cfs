class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :find_user, only: [:show, :edit, :update]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = t "form.create"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t "edit.edit_success"
      redirect_to @user
    else
      flash.now[:danger] = t "edit.edit_fail"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password,
                                 :password_confirmation)
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "login_in.please_log_in"
    redirect_to login_url
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "form.found"
    redirect_to signup_path
  end
end
