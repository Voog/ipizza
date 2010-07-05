require 'rubygems'
require 'rake'

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = 'ipizza'
    
    gemspec.summary = 'Implements iPizza protocol to communicate with Estonian Banks'
    gemspec.description = <<-DESC
      Simplifies generating payment requests and parsing responses from banks when using iPizza protocol.
    DESC
    
    gemspec.email = 'priit@fraktal.ee'
    gemspec.homepage = 'http://github.com/priith/ipizza'
    gemspec.authors = ['Priit Haamer']
  end
rescue LoadError
  puts 'Jeweler not available. Install it with: gem install jeweler'
end