Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true
  config.action_dispatch.tld_length = 1 # Defaults to 1
  config.web_console.whitelisted_ips = %w( 0.0.0.0 )
  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load
  config.action_mailer.perform_deliveries = true
  # Configure default URL for action mailer
  config.hosts << "blockdelta.com"
  config.hosts << "dev.blockdelta.com"
  config.hosts << "api.blockdelta.local"
  config.hosts << /application\.local\Z/
  config.action_mailer.default_url_options = {:host =>'https://blockdelta.com'}

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true
  
  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.secret_key_base ="652d6c363bf39ade301607615d25d53389b0371954bb478678bed21c6b7099d661d66a995e1ee31817950792eb2efcb9e0e3a45039f952215d3835a1a04dabff"
end
