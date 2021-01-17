# frozen_string_literal: true

require_relative 'tagged_logging/formatter'

module TaggedLogging
  include ::ActiveSupport::TaggedLogging

  def self.new(logger)
    logger = logger.dup
    logger.formatter = logger.formatter.dup if logger.formatter
    logger.formatter ||= ::ActiveSupport::Logger::SimpleFormatter.new
    logger.formatter.extend ::TaggedLogging::Formatter
    logger.extend(self)
  end

  def tagged(*tags)
    if block_given?
      formatter.tagged(*tags) { yield self }
    else
      logger = ::TaggedLogging.new(self)
      logger.formatter.extend ::ActiveSupport::TaggedLogging::LocalTagStorage
      logger.push_tags(*formatter.current_tags, *tags)
      logger
    end
  end
end
