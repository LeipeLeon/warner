require "bundler/setup"
require "warner"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

module Helpers
  def capture_stdout
    old_stdout = $stdout
    out = StringIO.new
    $stdout = out
    yield
    out
  ensure
    $stdout = old_stdout
  end

  def capture_stderr
    old_stderr = $stderr
    out = StringIO.new
    $stderr = out
    yield
    out
  ensure
    $stderr = old_stderr
  end
end

RSpec.configure do |c|
  c.include Helpers
end
