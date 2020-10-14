module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "layouts.application.base_title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def number_to_currency number, options = {precision: 0, locale: :vi}
    options[:locale] ||= I18n.locale
    super(number, options)
  end
end
