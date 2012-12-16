require 'rails'

require 'rspec/autorun'
Dir[File.join(File.dirname(__FILE__), 'support', '*.rb')].each {|f| require f}

require 'ipizza'

RSpec.configure do |config|
  config.mock_with :rspec
end
