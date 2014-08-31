module SweetLogger
  class Railtie < Rails::Railtie
    railtie_name :sweet_logger

    config.before_initialize do |app|
      Rails.configuration.middleware.swap(
        Rails::Rack::Logger, SweetLogger::Middleware
      )

      SweetLogger.silence %w{ /assets/ }
    end
  end
end
