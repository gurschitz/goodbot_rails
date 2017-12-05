require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GoodbotRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.active_job.queue_adapter = :sidekiq

    # We need to add the lib folder to the autoload_paths
    # as we're going to put our rails independent bot logic there
    # For production, we also need to enable_dependency_loading
    config.enable_dependency_loading = true
    config.autoload_paths << Rails.root.join('lib')

    # we configure the goodbag public_url
    config.goodbag = {
      public_url: 'https://www.goodbag.io'
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
