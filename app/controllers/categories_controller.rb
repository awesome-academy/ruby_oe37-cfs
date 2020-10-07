class CategoriesController < ApplicationController
  def new; end

  def show
    @categories = Category.page(params[:page]).per(10)
  end

  def create; end

  def destroy; end
end
