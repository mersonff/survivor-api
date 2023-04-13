# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SurvivorApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # I18n config
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}')]
    config.i18n.default_locale = :'pt-BR'

    config.log_level = :debug
    config.log_tags  = %i[subdomain uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(Logger.new($stdout))

    config.cache_store = :redis_store, ENV.fetch('REDIS_URL', nil),
      { namespace: 'survivor::cache' }

    config.api_only = true
  end
end
