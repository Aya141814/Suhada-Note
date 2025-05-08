require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Zeitwerkの設定
    config.autoloader = :zeitwerk
    
    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])
    
    if Rails.env.test?
      # テスト環境での自動読み込みの設定
      config.add_autoload_paths_to_load_path = true
      # autoload_lib実行後にパスを凍結
      config.autoload_paths.freeze
      config.eager_load_paths.freeze
    end

    config.i18n.default_locale = :ja
    config.time_zone = "Tokyo"
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # すべての環境で suhada-note.com を許可
    config.hosts << "suhada-note.com" unless Rails.env.production? # 本番環境では既に設定済み

    # テストで www.example.com を許可(ref:https://qiita.com/masaxyz_labo/items/ac27d652e301e212e8ce)
    config.hosts << ".example.com" if Rails.env.test?
  end
end
