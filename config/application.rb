require File.expand_path('boot', __dir__)

# Pick the frameworks you want:
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require "active_resource/railtie"
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(assets: %w[development test]))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Chill
  class Application < Rails::Application
    config.active_record.default_timezone = :utc
    I18n.config.enforce_available_locales = true

    config.generators do |generate|
      generate.test_framework :rspec
      generate.helper false
      generate.stylesheets false
      generate.javascript_engine false
      generate.view_specs false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = 'utf-8'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    # config.active_record.whitelist_attributes = false

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.initialize_on_precompile = false

    # Enable compression of HTTP responses for increased efficiency
    config.middleware.use Rack::Deflater

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.middleware.insert_before ActionDispatch::ParamsParser, 'CatchJsonParsingErrors'
    config.middleware.use Rack::Attack
    # Active Record suppresses errors raised within
    # `after_rollback`/`after_commit` callbacks, but these errors will
    # propagate in later versions of AR. Setting this to true allows the error
    # to propagate, so that we can find it.
    config.active_record.raise_in_transactional_callbacks = true
    config.middleware.use StackProf::Middleware, enabled: false,
                                                 mode: :cpu,
                                                 interval: 1000,
                                                 save_every: 5,
                                                 path: 'prof'

    config.log_formatter = proc do |severity, datetime, progname, msg|
      timestamp = datetime.strftime '%Y-%m-%d %H:%M:%S (%Z)'
      "#{timestamp} #{severity}: #{progname} #{msg}\n"
    end
    # Configuration settings
    config.x.api_documentation_link = "https://github.com/berkmancenter/lumendatabase/wiki/Lumen-API-Documentation"
    # Mailer settings
    config.default_sender = ENV['DEFAULT_SENDER'] || 'no-reply@example.com'
    config.return_path = ENV['RETURN_PATH'] || 'user@example.com'
    config.site_host = ENV['SITE_HOST'] || 'example.com'
  end
end
