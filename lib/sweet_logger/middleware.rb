#
# The rack middleware patch for `Rails::Rack::Logger`
#
module SweetLogger
  class Middleware < Rails::Rack::Logger

    def initialize(*args, &block)
      super

      @logstash = SweetLogger::Logstash.new
    end

    def call(env)
      @logstash.wrap env['PATH_INFO'] do
        super env
      end
    end

  end
end
