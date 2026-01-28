require 'factory_bot_rails'


RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end


ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
