require_relative "boot"
require "rails/all"
require "csv"
Bundler.require(*Rails.groups)
module RubyOe37Cfs
  class Application < Rails::Application
    config.load_defaults 6.0
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en, :vi]
    config.generators do |g|
      g.test_framework :rspec,
                       request_specs: false,
                       view_specs: false,
                       routing_specs: false,
                       helper_specs: false,
                       controller_specs: true
    end
  end
end
