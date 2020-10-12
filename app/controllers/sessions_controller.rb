class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      check_active
    else
      flash.now[:danger] = t "login.invalid"
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = t "login.logged_out"
    redirect_to root_url
  end

  private

  def check_active
    user = User.find_by(email: params[:session][:email].downcase)
    if user.activated?
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:warning] = t "login.not_active"
      redirect_to root_url
    end
  end
end
