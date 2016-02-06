require 'rubocop'

project_path = File.join(File.dirname(__FILE__), '..')
rubocop_path = File.join(project_path, 'vendor/rubocop')
unless File.directory?(rubocop_path)
  raise "Can't run specs without a local RuboCop checkout. Look in the README."
end
Dir["#{rubocop_path}/spec/support/**/*.rb"].each { |f| require f }
Dir["#{project_path}/spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.order = :random

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect # Disable `should`
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect # Disable `should_receive` and `stub`
  end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubocop-cask'
