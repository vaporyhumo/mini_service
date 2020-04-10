# typed: false
# frozen_string_literal: true

if ENV['CRYSTALBALL'] == 'true'
  require 'crystalball'

  Crystalball::MapGenerator.start! do |config|
    config.register Crystalball::MapGenerator::CoverageStrategy.new
    config.register Crystalball::MapGenerator::DescribedClassStrategy.new
  end
else
  require 'simplecov'

  SimpleCov.start do
    SimpleCov.minimum_coverage 100
    SimpleCov.minimum_coverage_by_file 100
    SimpleCov.refuse_coverage_drop
    add_group 'Files', %r{^/lib}
    add_group 'Specs', %r{_spec\.rb$}
  end
end

require 'mini_service'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
    c.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
