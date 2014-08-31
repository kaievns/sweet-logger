module SweetLogger
  extend self

  def silence(routes)
  end
end

require_relative "./sweet_logger/version"
require_relative "./sweet_logger/middleware"
require_relative "./sweet_logger/logstash"
require_relative "./sweet_logger/railtie"
