class Admin::UsersController < ApplicationController
  layout "application"
  def index
   @users = User.activate.paginate(page: params[:page]).per_page(Settings.user.page)
   respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
      format.xls { send_data @users.to_csv }
      end
    end
  def show; end
end
