# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'tagged_logging'
  spec.version = '1.0.0'
  spec.summary = 'ActiveSupport::TaggedLogging with multiline support'
  spec.authors = ['Vladimir Kleshko']

  spec.files = %w[
    lib/tagged_logging.rb
    lib/tagged_logging/formatter.rb
  ]

  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '~> 6.0'
end
