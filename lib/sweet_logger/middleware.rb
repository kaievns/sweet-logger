#
# The rack middle ware patch for `Rails::Rack::Logger`
#
module SweetLogger
  class Middleware < Rails::Rack::Logger
  end
end
