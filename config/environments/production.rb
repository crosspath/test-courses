# frozen_string_literal: true

require "active_support/core_ext/integer/time"

Rails.application.configure do
  # config.action_cable.mount_path = nil
  # config.action_cable.url = "wss://example.com/cable"
  # config.action_cable.allowed_request_origins = [ "http://example.com", /http:\/\/example.*/ ]

  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  config.active_record.dump_schema_after_migration = false
  config.active_support.report_deprecations = false
  # config.asset_host = "http://assets.example.com"
  # config.assume_ssl = true
  # config.cache_store = :mem_cache_store
  config.consider_all_requests_local = false
  config.eager_load = true
  config.enable_reloading = false
  config.force_ssl = true

  # config.hosts = [
  #   "example.com",     # Allow requests from example.com
  #   /.*\.example\.com/ # Allow requests from subdomains like `www.example.com`
  # ]
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }

  config.i18n.fallbacks = true

  # "info" includes generic and useful information about system operation, but avoids logging
  # too much
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  config.logger = ActiveSupport::Logger.new($stdout)
    .tap { |logger| logger.formatter = Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }
  config.log_tags = [:request_id]

  # config.public_file_server.enabled = false
  # config.require_master_key = true
end
