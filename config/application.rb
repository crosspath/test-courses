# frozen_string_literal: true

require_relative "boot"

require "rails"
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Courses
  class Application < Rails::Application
    config.load_defaults(7.1)

    config.api_only = true
    config.autoload_lib(ignore: %w[assets tasks])

    config.generators do |g|
      g.factory_bot(dir: "factories", filename_proc: ->(t) { t.singularize })
    end
  end
end
