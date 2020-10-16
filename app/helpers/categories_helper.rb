module CategoriesHelper
  def create_index params_page, index, per_page
    params_page = 1 if params_page.nil?
    (params_page.to_i - 1) * per_page.to_i + index.to_i + 1
  end

  def load_categories_of_user
    @categories = current_user.categories.activate.newest
      .paginate(page: params[:page]).per_page(Settings.user.page)
  end
end
