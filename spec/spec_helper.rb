# typed: false
# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  enable_coverage :branch

  minimum_coverage line: 100, branch: 100
  minimum_coverage_by_file 100
  refuse_coverage_drop

  add_group 'Files', %r{^/lib}
  add_group 'Specs', %r{_spec\.rb$}
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
