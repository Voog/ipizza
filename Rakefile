require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = 'ipizza'
    
    gemspec.summary = 'Implements iPizza protocol to communicate with Estonian Banks'
    gemspec.description = <<-DESC
      Simplifies generating payment requests and parsing responses from banks when using iPizza protocol.
    DESC
    
    gemspec.email = 'priit@fraktal.ee'
    gemspec.homepage = 'http://github.com/priithaamer/ipizza'
    gemspec.authors = ['Priit Haamer']
  end
rescue LoadError
  puts 'Jeweler not available. Install it with: gem install jeweler'
end

task :default => :spec