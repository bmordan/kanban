require "rspec"
require "capybara/rspec"
require "capybara/dsl"
require_relative "../server.rb"

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.include Capybara::DSL
  config.order = "default"

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

# Define the application we're testing
def app
  # Load the application defined in config.ru
  Rack::Builder.parse_file("config.ru").first
end

# Configure Capybara to test against the application above.
Capybara.app = app
Capybara.server = :webrick
