# Reference http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.default_formatter = config.files_to_run.one? ? 'doc' : 'progress'
  config.order = :random
  Kernel.srand config.seed
end
