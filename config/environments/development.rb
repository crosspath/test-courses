require "active_support/core_ext/integer/time"

Rails.application.configure do
  # config.action_cable.disable_request_forgery_protection = true
  config.action_controller.raise_on_missing_callback_actions = true
  # config.action_view.annotate_rendered_view_with_filenames = true
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []

  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.consider_all_requests_local = true
  config.eager_load = false
  config.enable_reloading = true
  # config.i18n.raise_on_missing_translations = true
  config.server_timing = true
end
