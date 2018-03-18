# frozen_string_literal: true

require 'pry'

require_relative '../lib/scrapper'
require_relative '../lib/exchange_rate'
require_relative '../api/app'

RSpec.configure do |config|
  config.expect_with :rspec do |e|
    e.include_chain_clauses_in_custom_matcher_descriptions = true
    e.syntax = :expect
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'spec/examples.txt'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
end
