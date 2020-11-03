class CategoriesController < ApplicationController
  before_action :find_category_id, only: :destroy
  before_action :authenticate_user!
  before_action :load_categories_of_user, only: %i(index create)

  def index
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.valid?
      @category.save
      flash[:success] = t "category.success"
      redirect_to request.referer || categories_path
    else
      render :index
    end
  end

  def destroy
    if @category.activate?
      @category.inactive!
      flash[:success] = t "category.deleted"
    else
      flash[:danger] = t "category.failed"
    end
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category_id
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:warning] = t "category.error"
    redirect_to root_path
  end
end
