module SweetLogger
  class Railtie < Rails::Railtie
    railtie_name :sweet_logger

    config.after_initialize do |app|

    end
  end
end
