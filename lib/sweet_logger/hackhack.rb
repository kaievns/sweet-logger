#
# Hack hack hack
#
# This makes the logger to write into a current thread
# stash while it's blocked by other threads.
#
ActiveSupport::Logger.class_eval do

  alias :add_before_sweet_logger :add

  def add(*args, &block)
    if Thread.current[:sweet_logger_stash]
      Thread.current[:sweet_logger_stash].push [self, args, block]
    else
      add_before_sweet_logger *args, &block
    end
  end

end
