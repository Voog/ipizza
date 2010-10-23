require 'ipizza'

Spec::Runner.configure do |config|
  
  config.before(:each) do
    # Load configuration for tests
    Ipizza::Config.load_from_file(File.expand_path(File.dirname(__FILE__) + '/../config/config.yml'))
  end
  
end
