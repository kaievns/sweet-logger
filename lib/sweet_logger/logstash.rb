#
# A little queue to stash logs while the STDOUT it blocked
# by another threads
#
require "thread"

module SweetLogger
  class Logstash
    MUTEX = Mutex.new

    def self.silence(routes)
      @silencer_re = /#{ routes.map { |e| Regexp.escape(e) }.join("|") }/
    end

    def self.silencer_re
      @silencer_re
    end

    def wrap(path, &block)
      silenced = shall_be_silenced?(path)
      we_started_this = ! Thread.main[:sweet_logger_stash]

      MUTEX.synchronize do
        if we_started_this && ! silenced
          Thread.main[:sweet_logger_stash] = []
        else
          Thread.current[:sweet_logger_stash] = []
        end
      end

      yield

    ensure
      MUTEX.synchronize do
        if silenced || ! Thread.current[:sweet_logger_stash]
          Thread.current[:sweet_logger_stash] = []
        end

        if Thread.main[:sweet_logger_stash]
          if we_started_this
            flush Thread.main[:sweet_logger_stash]
            Thread.main[:sweet_logger_stash] = nil
          else
            Thread.main[:sweet_logger_stash] += Thread.current[:sweet_logger_stash]
          end

        elsif
          flush Thread.current[:sweet_logger_stash]
        end

        Thread.current[:sweet_logger_stash] = nil
      end
    end

    def flush(entries)
      entries.each do |logger, args, block|
        logger.add_before_sweet_logger *args, &block
      end
    end

    def shall_be_silenced?(path)
      path =~ self.class.silencer_re
    end
  end
end
