class CategoriesController < ApplicationController
  before_action :check_logged, only: [:index, :create, :destroy]
  before_action :find_category_id, only: [:destroy]
  before_action :load_categories, only: [:index, :create]

  def index
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.valid?
      if @category.save
        flash[:success] = t "category.success"
        redirect_to request.referer || index_path
      else
        flash[:danger] = t "category.failed"
        redirect_to :index_path
      end
    else
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

  def load_categories
    @categories = current_user.categories.activate.newest.paginate(page: params[:page])
                              .per_page(Settings.user.page)
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
