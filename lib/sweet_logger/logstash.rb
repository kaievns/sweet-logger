#
# A little queue to stash logs while the STDOUT it blocked
# by another threads
#
module SweetLogger
  class Logstash
    def self.silence(routes)
      @silencer_re = /#{ routes.map { |e| Regexp.escape(e) }.join("|") }/
    end

    def self.silencer_re
      @silencer_re
    end

    def wrap(path, &block)
      if shall_be_silenced?(path)
        Thread.current[:sweet_logger_lock] = true
      end

      yield

    ensure
      Thread.current[:sweet_logger_lock] = false
      flush
    end

    def flush
    end

    def shall_be_silenced?(path)
      path =~ self.class.silencer_re
    end
  end
end
