class Admin::UsersController < ApplicationController
  layout "application"

  def index
    @users = User.newest.paginate(page: params[:page])
      .per_page(Settings.user.page)
  end
end
