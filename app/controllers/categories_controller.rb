class CategoriesController < ApplicationController
  before_action :check_logged, only: [:index, :create, :destroy]
  before_action :find_category_id, only: [:destroy]

  def index
    @categories = current_user.categories.activate.paginate(page: params[:page]).per_page(Settings.user.page)
  end

  def create
    @categories = current_user.categories.build(category_params)
    if @categories.save
      flash[:success] = t "category.success"
      redirect_to request.referer || index_path
    else
      flash.now[:danger] = t "category.failed"
      render :index
    end
  end

  def destroy
    if @category.inactive!
      flash[:success] = t "category.deleted"
    else
      flash[:danger] = t "category.failed"
    end
    redirect_to request.referer || index_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category_id
    @category = current_user.categories.find_by id: params[:id]
    return if @category

    flash[:warning] = t "category.error"
    redirect_to root_path
  end

  def check_logged
    return if logged_in?

    flash[:danger] = t "login.please_log_in"
    redirect_to login_url
  end
end
