class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      redirect_to home_path
      flash[:success] = t "login.logged_in_successfully"
    else
      flash.now[:danger] = t "login.Invalid_email"
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = t "login.logged_out"
    redirect_to root_url
  end
end
