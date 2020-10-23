class CategoriesController < ApplicationController
  before_action :find_category_id, only: :destroy

  def index
    @categories = current_user.categories.activate.newest
      .paginate(page: params[:page]).per_page(Settings.user.page)
  end

  def create
    @category = current_user.categories.build(category_params)
    @error_name = []

    return if @category.save

    @category.errors.any?
    @error_name.push(@category.errors["name"][0]) if
      @category.errors["name"].present?

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @category.inactive!
    flash[:success] = t "category.deleted"
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
