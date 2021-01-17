# frozen_string_literal: true

module TaggedLogging
  module Formatter
    include ::ActiveSupport::TaggedLogging::Formatter

    FORMAT = "%s [%s#%d] %s%s%s\n"
    COLORS = {
      DEBUG: ::ActiveSupport::LogSubscriber::CYAN,
      INFO: ::ActiveSupport::LogSubscriber::CYAN,
      WARN: ::ActiveSupport::LogSubscriber::YELLOW,
      ERROR: ::ActiveSupport::LogSubscriber::RED,
      FATAL: ::ActiveSupport::LogSubscriber::RED
    }.stringify_keys.freeze

    def call(severity, time, progname, msg)
      progname = "#{progname}: " if progname.present?

      msg.to_s.split("\n").map do |line|
        format(
          ::TaggedLogging::Formatter::FORMAT,
          severity_text(severity),
          time.strftime('%Y-%m-%d %H:%M:%S.%2N '),
          ::Process.pid,
          progname,
          tags_text,
          line
        )
      end.join
    end

    private

    def severity_text(severity)
      text = "[#{severity[0..0]}]"
      return text unless ::ActiveSupport::LogSubscriber.colorize_logging

      color = ::TaggedLogging::Formatter::COLORS[severity]
      "#{color}#{text}#{::ActiveSupport::LogSubscriber::CLEAR}"
    end
  end
end
