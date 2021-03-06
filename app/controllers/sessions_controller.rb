class SessionsController < ApplicationController
  before_action :find_email, only: [:create]
  before_action :check_session, only: [:create]
  before_action :check_logged, except: [:new, :create, :check_session]

  def new; end

  def create
    if @user&.activate?
      check_active
    elsif @user&.inactive?
      flash.now[:danger] =
        t "manger_user.account_lockout"
      render :new
    else
      flash.now[:danger] = t "login.invalid"
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = t "login.logged_out"
    redirect_to login_path
  end

  private

  def check_active
    if @user.activated?
      log_in @user
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      flash[:warning] = t "login.not_active"
      redirect_to root_url
    end
  end

  def find_email
    return if @user = User.find_by(email: params[:session][:email].downcase)

    flash[:danger] = t "manger_user.not_user"
    redirect_to login_path
  end

  def check_session
    @user = @user&.authenticate(params[:session][:password])
    return if @user.present?

    flash[:danger] = t "login.invalid"
    redirect_to login_path
  end
end
