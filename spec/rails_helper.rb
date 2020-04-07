require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include FeatureAuthenticationHelper, type: :feature
  config.include ControllerAuthenticationHelper, type: :controller
  config.include ActiveJob::TestHelper, type: :feature
  config.include CarrierWave::Test::Matchers, type: :uploader
end
