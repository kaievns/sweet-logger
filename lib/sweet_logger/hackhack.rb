#
# Hack hack hack
#
# This is where we add the logger lock to prevent it from
# flushing stuff while other threads write to it
#
ActiveSupport::Logger.class_eval do

  alias :add_before_sweet_logger :add

  def add(*args, &block)
    if ! Thread.current[:sweet_logger_lock]
      add_before_sweet_logger *args, &block
    end
  end

end
